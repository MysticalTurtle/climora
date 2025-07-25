import 'package:climora/core/error/failure.dart';
import 'package:climora/data/datasources/local/local_weather_ds.dart';
import 'package:climora/data/datasources/remote/remote_weather_ds.dart';
import 'package:climora/data/model/weather_model.dart';
import 'package:climora/data/repositories/weather_repository_i.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteWeatherDS extends Mock implements RemoteWeatherDS {}

class MockLocalWeatherDS extends Mock implements LocalWeatherDS {}

class FakeWeatherModel extends Fake implements WeatherModel {}

void main() {
  late WeatherRepositoryI repository;
  late MockRemoteWeatherDS mockRemoteDS;
  late MockLocalWeatherDS mockLocalDS;

  setUpAll(() {
    registerFallbackValue(FakeWeatherModel());
  });

  setUp(() {
    mockRemoteDS = MockRemoteWeatherDS();
    mockLocalDS = MockLocalWeatherDS();
    repository = WeatherRepositoryI(
      remoteDS: mockRemoteDS,
      localDS: mockLocalDS,
    );
  });

  group('WeatherRepositoryI', () {
    const lat = 40.7143;
    const lon = -74.006;

    final mockWeatherModel = WeatherModel.fromMap(const {
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
    });

    group('getCurrentWeather', () {
      test('should return cached weather when available', () async {
        // Arrange
        when(
          () => mockLocalDS.getCachedWeather(lat, lon),
        ).thenAnswer((_) async => mockWeatherModel);

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        // Assert
        expect(result.$1, isNull); // No failure
        expect(result.$2, isA<Weather>());
        expect(result.$2!.name, equals('New York'));
        verify(() => mockLocalDS.getCachedWeather(lat, lon)).called(1);
        verifyNever(() => mockRemoteDS.getCurrentWeather(lat: lat, lon: lon));
      });

      test('should fetch from remote and cache when no cached data', () async {
        // Arrange
        when(
          () => mockLocalDS.getCachedWeather(lat, lon),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDS.getCurrentWeather(lat: lat, lon: lon),
        ).thenAnswer((_) async => mockWeatherModel);
        when(
          () => mockLocalDS.cacheWeather(mockWeatherModel, lat, lon),
        ).thenAnswer((_) async => true);

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        // Assert
        expect(result.$1, isNull); // No failure
        expect(result.$2, isA<Weather>());
        expect(result.$2!.name, equals('New York'));
        verify(() => mockLocalDS.getCachedWeather(lat, lon)).called(1);
        verify(
          () => mockRemoteDS.getCurrentWeather(lat: lat, lon: lon),
        ).called(1);
        verify(
          () => mockLocalDS.cacheWeather(mockWeatherModel, lat, lon),
        ).called(1);
      });

      test('should return failure when remote fetch fails', () async {
        // Arrange
        when(
          () => mockLocalDS.getCachedWeather(lat, lon),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDS.getCurrentWeather(lat: lat, lon: lon),
        ).thenThrow(const Failure(message: 'Server error'));

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        // Assert
        expect(result.$1, isA<Failure>());
        expect(result.$2, isNull);
        verify(() => mockLocalDS.getCachedWeather(lat, lon)).called(1);
        verify(
          () => mockRemoteDS.getCurrentWeather(lat: lat, lon: lon),
        ).called(1);
        verifyNever(() => mockLocalDS.cacheWeather(any(), any(), any()));
      });

      test('should handle exception and return failure', () async {
        // Arrange
        when(
          () => mockLocalDS.getCachedWeather(lat, lon),
        ).thenThrow(Exception('Database error'));

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        // Assert
        expect(result.$1, isA<Failure>());
        expect(result.$2, isNull);
      });
    });
  });
}
