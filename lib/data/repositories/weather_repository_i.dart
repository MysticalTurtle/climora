import 'package:climora/core/error/failure.dart';
import 'package:climora/data/datasources/local/local_weather_ds.dart';
import 'package:climora/data/datasources/remote/remote_weather_ds.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:climora/domain/entities/weather_forecast.dart';
import 'package:climora/domain/repositories/weather_repository.dart';

class WeatherRepositoryI extends WeatherRepository {
  WeatherRepositoryI({
    required this.remoteDS,
    required this.localDS,
  });

  final RemoteWeatherDS remoteDS;
  final LocalWeatherDS localDS;

  @override
  Future<(Failure?, Weather?)> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final cachedWeather = await localDS.getCachedWeather(lat, lon);
      if (cachedWeather != null) {
        final weatherEntity = Weather.fromMap(cachedWeather.toMap());
        return (null, weatherEntity);
      }

      final weatherModel = await remoteDS.getCurrentWeather(
        lat: lat,
        lon: lon,
      );
      
      await localDS.cacheWeather(weatherModel, lat, lon);
      
      final weatherEntity = Weather.fromMap(weatherModel.toMap());
      return (null, weatherEntity);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }

  @override
  Future<(Failure?, WeatherForecast?)> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final cachedForecast = await localDS.getCachedForecast(lat, lon);
      if (cachedForecast != null) {
        final forecastEntity = WeatherForecast.fromMap(cachedForecast.toMap());
        return (null, forecastEntity);
      }

      final forecastModel = await remoteDS.getWeatherForecast(
        lat: lat,
        lon: lon,
      );
      
      await localDS.cacheForecast(forecastModel, lat, lon);
      
      final forecastEntity = WeatherForecast.fromMap(forecastModel.toMap());
      return (null, forecastEntity);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }

  @override
  Future<(Failure?, List<GeocodingLocation>?)> searchLocations({
    required String query,
    int limit = 5,
  }) async {
    try {
      final locationsModel = await remoteDS.searchLocations(
        query: query,
        limit: limit,
      );
      final jsonList = locationsModel.map((e) => e.toMap()).toList();
      final locationsEntities = jsonList
          .map(GeocodingLocation.fromMap)
          .toList();
      return (null, locationsEntities);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }
}
