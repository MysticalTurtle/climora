import 'package:climora/data/model/weather_model.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherModel', () {
    const mockWeatherJson = {
      'weather': [
        {
          'id': 800,
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01d',
        }
      ],
      'main': {
        'temp': 298.15,
        'feels_like': 298.15,
        'temp_min': 295.15,
        'temp_max': 301.15,
        'pressure': 1013,
        'humidity': 45,
      },
      'visibility': 10000,
      'wind': {
        'speed': 3.6,
        'deg': 230,
      },
      'clouds': {
        'all': 0,
      },
      'dt': 1640995200,
      'sys': {
        'type': 2,
        'id': 2000000,
        'country': 'US',
        'sunrise': 1640966400,
        'sunset': 1641002400,
      },
      'timezone': -18000,
      'id': 5128581,
      'name': 'New York',
      'cod': 200,
      'coord': {
        'lon': -74.006,
        'lat': 40.7143,
      },
    };

    test('should create WeatherModel from Map', () {
      // Act
      final weatherModel = WeatherModel.fromMap(mockWeatherJson);

      // Assert
      expect(weatherModel, isA<WeatherModel>());
      expect(weatherModel.name, equals('New York'));
      expect(weatherModel.id, equals(5128581));
      expect(weatherModel.cod, equals(200));
      expect(weatherModel.timezone, equals(-18000));
      expect(weatherModel.dt, equals(1640995200));
      expect(weatherModel.visibility, equals(10000));
    });

    test('should convert WeatherModel to Map', () {
      // Arrange
      final weatherModel = WeatherModel.fromMap(mockWeatherJson);

      // Act
      final map = weatherModel.toMap();

      // Assert
      expect(map, isA<Map<String, dynamic>>());
      expect(map['name'], equals('New York'));
      expect(map['id'], equals(5128581));
      expect(map['cod'], equals(200));
      expect(map['timezone'], equals(-18000));
    });

    test('should convert WeatherModel to Weather entity', () {
      // Arrange
      final weatherModel = WeatherModel.fromMap(mockWeatherJson);

      // Act
      final weather = Weather.fromMap(weatherModel.toMap());

      // Assert
      expect(weather, isA<Weather>());
      expect(weather.name, equals('New York'));
      expect(weather.id, equals(5128581));
      expect(weather.cod, equals(200));
      expect(weather.timezone, equals(-18000));
      expect(weather.dt, equals(1640995200));
      expect(weather.visibility, equals(10000));
      expect(weather.weather.length, equals(1));
      expect(weather.weather.first.main, equals('Clear'));
      expect(weather.main.temp, equals(298.15));
      expect(weather.wind.speed, equals(3.6));
      expect(weather.clouds.all, equals(0));
      expect(weather.sys.country, equals('US'));
      expect(weather.coord.lat, equals(40.7143));
      expect(weather.coord.lon, equals(-74.006));
    });

    test('should handle missing optional fields gracefully', () {
      // Arrange
      final minimalJson = {
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          }
        ],
        'main': {
          'temp': 298.15,
          'feels_like': 298.15,
          'temp_min': 295.15,
          'temp_max': 301.15,
          'pressure': 1013,
          'humidity': 45,
        },
        'wind': {
          'speed': 3.6,
          'deg': 230,
        },
        'clouds': {
          'all': 0,
        },
        'dt': 1640995200,
        'sys': {
          'type': 2,
          'id': 2000000,
          'country': 'US',
          'sunrise': 1640966400,
          'sunset': 1641002400,
        },
        'timezone': -18000,
        'id': 5128581,
        'name': 'New York',
        'cod': 200,
        'coord': {
          'lon': -74.006,
          'lat': 40.7143,
        },
      };

      // Act
      final weatherModel = WeatherModel.fromMap(minimalJson);

      // Assert
      expect(weatherModel, isA<WeatherModel>());
      expect(weatherModel.name, equals('New York'));
      expect(weatherModel.visibility, equals(0)); // Default value when missing
    });
  });
}
