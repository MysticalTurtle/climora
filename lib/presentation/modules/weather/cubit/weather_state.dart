part of 'weather_cubit.dart';

enum WeatherStatus {
  firstTime,
  hasLocation,
  loadingLocation,
  loadingWeather,
  success,
  failure,
  permissionDeniedForever;

  bool get isFirstTime => this == WeatherStatus.firstTime;
  bool get isHasLocation => this == WeatherStatus.hasLocation;
  bool get isLoadingLocation => this == WeatherStatus.loadingLocation;
  bool get isLoadingWeather => this == WeatherStatus.loadingWeather;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
  bool get isPermissionDeniedForever =>
      this == WeatherStatus.permissionDeniedForever;
  bool get isLoading => isLoadingLocation || isLoadingWeather;
}

class WeatherState extends Equatable {
  const WeatherState({
    required this.status,
    this.weather,
    this.savedLocation,
    this.failure,
  });

  const WeatherState.initial()
    : status = WeatherStatus.firstTime,
      weather = null,
      savedLocation = null,
      failure = null;

  final WeatherStatus status;
  final Weather? weather;
  final GeocodingLocation? savedLocation;
  final Failure? failure;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    GeocodingLocation? savedLocation,
    Failure? failure,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      savedLocation: savedLocation ?? this.savedLocation,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, weather, savedLocation, failure];
}
