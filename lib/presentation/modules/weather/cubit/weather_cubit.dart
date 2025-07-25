import 'package:bloc/bloc.dart';
import 'package:climora/core/core.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> with WidgetsBindingObserver {
  WeatherCubit({
    required this.repository,
    required this.locationService,
  }) : super(const WeatherState.initial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  final WeatherRepository repository;
  final LocationService locationService;
  bool _wasPermissionDeniedForever = false;

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  void init({GeocodingLocation? initialLocation}) {
    if (initialLocation != null) {
      loadWeatherForLocation(initialLocation);
    } else {
      checkInitialState();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed && _wasPermissionDeniedForever) {
      _checkPermissionsAfterSettings();
    }
  }

  Future<void> _checkPermissionsAfterSettings() async {
    try {
      final serviceEnabled = await locationService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          state.copyWith(
            status: WeatherStatus.failure,
            failure: const Failure(
              message: 'Location services are disabled',
            ),
          ),
        );
        return;
      }

      final permission = await locationService.checkPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _wasPermissionDeniedForever = false;
        await getCurrentLocation();
      } else if (permission == LocationPermission.deniedForever) {
        return;
      } else {
        emit(
          state.copyWith(
            status: WeatherStatus.failure,
            failure: const Failure(message: 'Location permissions denied'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          failure: const Failure(
            message: 'Error checking location permissions',
          ),
        ),
      );
    }
  }

  Future<void> checkInitialState() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLocation = prefs.getBool('has_saved_location') ?? false;

    if (hasLocation) {
      final lat = prefs.getDouble('saved_lat');
      final lon = prefs.getDouble('saved_lon');
      final name = prefs.getString('saved_location_name');

      if (lat != null && lon != null && name != null) {
        emit(
          state.copyWith(
            status: WeatherStatus.hasLocation,
            savedLocation: GeocodingLocation(
              name: name,
              lat: lat,
              lon: lon,
              country: prefs.getString('saved_country') ?? '',
              state: prefs.getString('saved_state'),
              localNames: const LocalNames(),
            ),
          ),
        );
        await loadWeatherForSavedLocation();
      } else {
        emit(state.copyWith(status: WeatherStatus.firstTime));
      }
    } else {
      emit(state.copyWith(status: WeatherStatus.firstTime));
    }
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(status: WeatherStatus.loadingLocation));

    try {
      final permission = await locationService.checkAndRequestPermissions();

      if (permission == LocationPermission.deniedForever) {
        _wasPermissionDeniedForever = true;
        emit(
          state.copyWith(
            status: WeatherStatus.permissionDeniedForever,
          ),
        );
        return;
      }

      final position = await locationService.getCurrentPosition();

      if (position != null) {
        await _loadWeatherForPosition(position);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          failure: Failure(message: e.toString()),
        ),
      );
    }
  }

  Future<void> _loadWeatherForPosition(Position position) async {
    emit(state.copyWith(status: WeatherStatus.loadingWeather));

    final (failure, weather) = await repository.getCurrentWeather(
      lat: position.latitude,
      lon: position.longitude,
    );

    if (failure != null) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          failure: failure,
        ),
      );
      return;
    }

    if (weather != null) {
      await _saveLocation(
        lat: position.latitude,
        lon: position.longitude,
        name: weather.name,
        country: weather.sys.country,
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          savedLocation: GeocodingLocation(
            name: weather.name,
            lat: position.latitude,
            lon: position.longitude,
            country: weather.sys.country,
            localNames: const LocalNames(),
          ),
        ),
      );
    }
  }

  Future<void> loadWeatherForLocation(GeocodingLocation location) async {
    emit(state.copyWith(status: WeatherStatus.loadingWeather));

    final (failure, weather) = await repository.getCurrentWeather(
      lat: location.lat,
      lon: location.lon,
    );

    if (failure != null) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          failure: failure,
        ),
      );
      return;
    }

    if (weather != null) {
      await _saveLocation(
        lat: location.lat,
        lon: location.lon,
        name: location.name,
        country: location.country,
        state: location.state,
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          savedLocation: location,
        ),
      );
    }
  }

  Future<void> loadWeatherForSavedLocation() async {
    if (state.savedLocation == null) return;

    emit(state.copyWith(status: WeatherStatus.loadingWeather));

    final (failure, weather) = await repository.getCurrentWeather(
      lat: state.savedLocation!.lat,
      lon: state.savedLocation!.lon,
    );

    if (failure != null) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          failure: failure,
        ),
      );
      return;
    }

    if (weather != null) {
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
    }
  }

  Future<void> _saveLocation({
    required double lat,
    required double lon,
    required String name,
    required String country,
    String? state,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_saved_location', true);
    await prefs.setDouble('saved_lat', lat);
    await prefs.setDouble('saved_lon', lon);
    await prefs.setString('saved_location_name', name);
    await prefs.setString('saved_country', country);
    if (state != null) {
      await prefs.setString('saved_state', state);
    }
  }

  Future<void> retryLocationPermissions() async {
    await _checkPermissionsAfterSettings();
  }

  void openAppSettings() {
    _wasPermissionDeniedForever = true;
  }
}
