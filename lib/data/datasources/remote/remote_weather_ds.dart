import 'package:climora/core/core.dart';
import 'package:climora/data/model/geocoding_model.dart';
import 'package:climora/data/model/weather_forecast_model.dart';
import 'package:climora/data/model/weather_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteWeatherDS {
  Future<WeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  });

  Future<WeatherForecastModel> getWeatherForecast({
    required double lat,
    required double lon,
  });

  Future<List<GeocodingLocationModel>> searchLocations({
    required String query,
    int limit = 5,
  });
}

class RemoteWeatherDSI extends RemoteWeatherDS {
  RemoteWeatherDSI({required this.dio, required this.apiKey});

  final Dio dio;
  final String apiKey;

  @override
  Future<WeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/data/2.5/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
        },
      );

      final weather = WeatherModel.fromMap(response.data!);
      return weather;
    } catch (e) {
      if (e is DioException) {
        final message =
            (e.response?.data as Map<String, dynamic>?)?['message']
                as String? ??
            e.message ??
            'Weather API error';
        throw Failure(
          message: message,
        );
      }
      rethrow;
    }
  }

  @override
  Future<WeatherForecastModel> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/data/2.5/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
        },
      );

      final forecast = WeatherForecastModel.fromMap(response.data!);
      return forecast;
    } catch (e) {
      if (e is DioException) {
        final message = 
            (e.response?.data as Map<String, dynamic>?)?['message']
                as String? ??
            e.message ??
            'Forecast API error';
        throw Failure(
          message: message,
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<GeocodingLocationModel>> searchLocations({
    required String query,
    int limit = 5,
  }) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '/geo/1.0/direct',
        queryParameters: {
          'q': query,
          'limit': limit,
          'appid': apiKey,
        },
      );

      final locations = response.data!
          .map((e) => GeocodingLocationModel.fromMap(e as Map<String, dynamic>))
          .toList();

      return locations;
    } catch (e) {
      if (e is DioException) {
        final message = 
            (e.response?.data as Map<String, dynamic>?)?['message']
                as String? ??
            e.message ??
            'Geocoding API error';
        throw Failure(
          message: message,
        );
      }
      rethrow;
    }
  }
}
