import 'package:climora/app/app.dart';
import 'package:climora/core/core.dart';
import 'package:climora/domain/entities/favorite.dart';
import 'package:climora/domain/repositories/favorites_repository.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  late MockFavoritesRepository mockFavoritesRepository;
  late MockWeatherRepository mockWeatherRepository;
  late MockLocationService mockLocationService;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
    mockWeatherRepository = MockWeatherRepository();
    mockLocationService = MockLocationService();

    // Register all needed dependencies for testing
    GetIt.instance.registerSingleton<FavoritesRepository>(
      mockFavoritesRepository,
    );
    GetIt.instance.registerSingleton<WeatherRepository>(mockWeatherRepository);
    GetIt.instance.registerSingleton<LocationService>(mockLocationService);

    // Mock the getFavorites call
    when(
      () => mockFavoritesRepository.getFavorites(),
    ).thenAnswer((_) async => (null, <Favorite>[]));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  group('App', () {
    testWidgets('renders MaterialApp with correct structure', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump(); // Allow async operations to complete

      // Verify basic app structure
      expect(find.byType(MaterialApp), findsOneWidget);

      // The app should not crash and should render successfully
      expect(tester.takeException(), isNull);
    });

    testWidgets('app has correct theme configuration', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump();

      final materialApp =
          tester.widget(find.byType(MaterialApp)) as MaterialApp;

      // Verify theme is configured
      expect(materialApp.theme, isNotNull);
      expect(materialApp.theme!.useMaterial3, isTrue);
    });

    testWidgets('app has correct localization support', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump();

      final materialApp =
          tester.widget(find.byType(MaterialApp)) as MaterialApp;

      // Verify localization is configured
      expect(materialApp.localizationsDelegates, isNotNull);
      expect(materialApp.supportedLocales, isNotNull);
    });
  });
}
