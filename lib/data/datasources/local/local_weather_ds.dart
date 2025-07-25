import 'dart:convert';

import 'package:climora/core/db/database_helper.dart';
import 'package:climora/core/error/failure.dart';
import 'package:climora/data/model/weather_forecast_model.dart';
import 'package:climora/data/model/weather_model.dart';

abstract class LocalWeatherDS {
  Future<WeatherModel?> getCachedWeather(double lat, double lon);
  Future<bool> cacheWeather(WeatherModel weather, double lat, double lon);
  Future<WeatherForecastModel?> getCachedForecast(double lat, double lon);
  Future<bool> cacheForecast(
    WeatherForecastModel forecast,
    double lat,
    double lon,
  );
  Future<bool> clearExpiredCache();
  Future<bool> clearAllCache();
  Future<WeatherModel?> getCachedWeatherWithTolerance(
    double lat,
    double lon, {
    double tolerance = 0.01,
  });
}

class LocalWeatherDSI implements LocalWeatherDS {
  LocalWeatherDSI({required this.db});

  final DatabaseHelper db;

  // Cache expiration time (30 minutes for weather, 3 hours for forecast)
  static const int weatherCacheExpiryMinutes = 30;
  static const int forecastCacheExpiryMinutes = 180;

  @override
  Future<WeatherModel?> getCachedWeather(double lat, double lon) async {
    try {
      final response = await DatabaseHelper.instance.getCachedWeather(lat, lon);
      if (response == null) return null;

      // Check if cache is expired
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(
        response['cached_at'] as int,
      );
      final expiryTime = cachedTime.add(
        const Duration(minutes: weatherCacheExpiryMinutes),
      );

      if (DateTime.now().isAfter(expiryTime)) {
        // Cache expired, remove it
        await DatabaseHelper.instance.deleteCachedWeather(lat, lon);
        return null;
      }

      // Parse weather data from JSON string
      final weatherJson = response['weather_data'] as String;
      final weatherMap = jsonDecode(weatherJson) as Map<String, dynamic>;

      return WeatherModel.fromMap(weatherMap);
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error retrieving cached weather');
    }
  }

  @override
  Future<bool> cacheWeather(
    WeatherModel weather,
    double lat,
    double lon,
  ) async {
    try {
      final cacheData = {
        'lat': lat,
        'lon': lon,
        'weather_data': jsonEncode(weather.toMap()),
        'cached_at': DateTime.now().millisecondsSinceEpoch,
        'type': 'weather',
      };

      await DatabaseHelper.instance.cacheWeatherData(cacheData);
      return true;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error caching weather data');
    }
  }

  @override
  Future<WeatherForecastModel?> getCachedForecast(
    double lat,
    double lon,
  ) async {
    try {
      final response = await DatabaseHelper.instance.getCachedForecast(
        lat,
        lon,
      );
      if (response == null) return null;

      // Check if cache is expired
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(
        response['cached_at'] as int,
      );
      final expiryTime = cachedTime.add(
        const Duration(minutes: forecastCacheExpiryMinutes),
      );

      if (DateTime.now().isAfter(expiryTime)) {
        // Cache expired, remove it
        await DatabaseHelper.instance.deleteCachedForecast(lat, lon);
        return null;
      }

      // Parse forecast data from JSON string
      final forecastJson = response['weather_data'] as String;
      final forecastMap = jsonDecode(forecastJson) as Map<String, dynamic>;

      return WeatherForecastModel.fromMap(forecastMap);
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error retrieving cached forecast');
    }
  }

  @override
  Future<bool> cacheForecast(
    WeatherForecastModel forecast,
    double lat,
    double lon,
  ) async {
    try {
      final cacheData = {
        'lat': lat,
        'lon': lon,
        'weather_data': jsonEncode(forecast.toMap()),
        'cached_at': DateTime.now().millisecondsSinceEpoch,
        'type': 'forecast',
      };

      await DatabaseHelper.instance.cacheWeatherData(cacheData);
      return true;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error caching forecast data');
    }
  }

  @override
  Future<bool> clearExpiredCache() async {
    try {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final weatherExpiryTime =
          currentTime - (weatherCacheExpiryMinutes * 60 * 1000);
      final forecastExpiryTime =
          currentTime - (forecastCacheExpiryMinutes * 60 * 1000);

      await DatabaseHelper.instance.clearExpiredWeatherCache(
        weatherExpiryTime,
        forecastExpiryTime,
      );
      return true;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error clearing expired cache');
    }
  }

  @override
  Future<bool> clearAllCache() async {
    try {
      await DatabaseHelper.instance.clearAllWeatherCache();
      return true;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error clearing all cache');
    }
  }

  @override
  Future<WeatherModel?> getCachedWeatherWithTolerance(
    double lat,
    double lon, {
    double tolerance = 0.01,
  }) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final results = await db.query(
        'weather_cache',
        where: 'type = ? AND lat BETWEEN ? AND ? AND lon BETWEEN ? AND ?',
        whereArgs: [
          'weather',
          lat - tolerance,
          lat + tolerance,
          lon - tolerance,
          lon + tolerance,
        ],
        limit: 1,
      );

      if (results.isEmpty) return null;

      final response = results.first;

      // Check if cache is expired
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(
        response['cached_at'] as int? ?? 0,
      );
      final expiryTime = cachedTime.add(
        const Duration(minutes: weatherCacheExpiryMinutes),
      );

      if (DateTime.now().isAfter(expiryTime)) {
        // Cache expired, remove it
        await db.delete(
          'weather_cache',
          where: 'id = ?',
          whereArgs: [response['id']],
        );
        return null;
      }

      // Parse weather data from JSON string
      final weatherJson = response['weather_data'] as String? ?? '';
      final weatherMap = jsonDecode(weatherJson) as Map<String, dynamic>;

      return WeatherModel.fromMap(weatherMap);
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(
        message: 'Error retrieving cached weather with tolerance',
      );
    }
  }
}
