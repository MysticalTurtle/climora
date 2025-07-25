import 'package:climora/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Weather Entity', () {
    const mockWeatherJson = {
      'weather': [
        {
          'id': 800,
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01d',
        },
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
      'base': 'stations',
      'coord': {
        'lon': -74.006,
        'lat': 40.7143,
      },
    };

    test('should create Weather from Map correctly', () {
      // Act
      final weather = Weather.fromMap(mockWeatherJson);

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

    test('should convert Weather to Map correctly', () {
      // Arrange
      final weather = Weather.fromMap(mockWeatherJson);

      // Act
      final map = weather.toMap();

      // Assert
      expect(map, isA<Map<String, dynamic>>());
      expect(map['name'], equals('New York'));
      expect(map['id'], equals(5128581));
      expect(map['cod'], equals(200));
      expect(map['timezone'], equals(-18000));
    });

    test('should handle missing optional fields with defaults', () {
      // Arrange
      final minimalJson = {
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          },
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

      final weather = Weather.fromMap(minimalJson);

      expect(weather.visibility, equals(0));
      expect(weather.base, equals(''));
    });

    test('should handle copyWith functionality', () {
      final originalWeather = Weather.fromMap(mockWeatherJson);

      final updatedWeather = originalWeather.copyWith(
        name: 'Los Angeles',
        id: 9999,
      );

      // Assert
      expect(updatedWeather.name, equals('Los Angeles'));
      expect(updatedWeather.id, equals(9999));
      expect(updatedWeather.cod, equals(originalWeather.cod));
      expect(updatedWeather.timezone, equals(originalWeather.timezone));
    });
  });
}
