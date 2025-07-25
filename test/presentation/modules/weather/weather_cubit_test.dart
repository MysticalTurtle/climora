import 'package:bloc_test/bloc_test.dart';
import 'package:climora/core/core.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/entities/weather.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}
class MockLocationService extends Mock implements LocationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late WeatherCubit weatherCubit;
  late MockWeatherRepository mockWeatherRepository;
  late MockLocationService mockLocationService;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockLocationService = MockLocationService();
    weatherCubit = WeatherCubit(
      repository: mockWeatherRepository,
      locationService: mockLocationService,
    );
  });

  tearDown(() {
    weatherCubit.close();
  });

  group('WeatherCubit', () {
    const mockWeather = Weather(
      coord: Coord(lat: 40.7143, lon: -74.006),
      weather: [
        WeatherInfo(
          id: 800,
          main: 'Clear',
          description: 'clear sky',
          icon: '01d',
        ),
      ],
      base: 'stations',
      main: Main(
        temp: 298.15,
        feelsLike: 298.15,
        tempMin: 295.15,
        tempMax: 301.15,
        pressure: 1013,
        humidity: 45,
        seaLevel: 0,
        grndLevel: 0,
      ),
      visibility: 10000,
      wind: Wind(speed: 3.6, deg: 230),
      clouds: Clouds(all: 0),
      dt: 1640995200,
      sys: Sys(
        type: 2,
        id: 2000000,
        country: 'US',
        sunrise: 1640966400,
        sunset: 1641002400,
      ),
      timezone: -18000,
      id: 5128581,
      name: 'New York',
      cod: 200,
    );

    const mockLocation = GeocodingLocation(
      name: 'New York',
      lat: 40.7143,
      lon: -74.006,
      country: 'US',
      state: 'NY',
      localNames: LocalNames(),
    );

    test('initial state is WeatherState.initial', () {
      expect(weatherCubit.state, const WeatherState.initial());
    });


    group('loadWeatherForSavedLocation', () {
      blocTest<WeatherCubit, WeatherState>(
        'loads weather for saved location when available',
        build: () {
          when(() => mockWeatherRepository.getCurrentWeather(
                lat: any(named: 'lat'),
                lon: any(named: 'lon'),
              )).thenAnswer((_) async => (null, mockWeather));
          return weatherCubit;
        },
        seed: () => const WeatherState(
          status: WeatherStatus.hasLocation,
          savedLocation: mockLocation,
        ),
        act: (cubit) => cubit.loadWeatherForSavedLocation(),
        expect: () => [
          const WeatherState(
            status: WeatherStatus.loadingWeather,
            savedLocation: mockLocation,
          ),
          const WeatherState(
            status: WeatherStatus.success,
            weather: mockWeather,
            savedLocation: mockLocation,
          ),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'does nothing when no saved location',
        build: () => weatherCubit,
        act: (cubit) => cubit.loadWeatherForSavedLocation(),
        expect: () => <WeatherState>[],
      );
    });
  });
}
