import 'package:climora/core/error/failure.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:climora/domain/entities/weather_forecast.dart';

abstract class WeatherRepository {
  Future<(Failure?, Weather?)> getCurrentWeather({
    required double lat,
    required double lon,
  });

  Future<(Failure?, WeatherForecast?)> getWeatherForecast({
    required double lat,
    required double lon,
  });

  Future<(Failure?, List<GeocodingLocation>?)> searchLocations({
    required String query,
    int limit = 5,
  });
}
