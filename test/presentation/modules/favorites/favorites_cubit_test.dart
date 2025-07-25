import 'package:bloc_test/bloc_test.dart';
import 'package:climora/core/error/failure.dart';
import 'package:climora/domain/entities/favorite.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/repositories/favorites_repository.dart';
import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}
class FakeFavorite extends Fake implements Favorite {}

void main() {
  late FavoritesCubit favoritesCubit;
  late MockFavoritesRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeFavorite());
  });

  setUp(() {
    mockRepository = MockFavoritesRepository();
    favoritesCubit = FavoritesCubit(repository: mockRepository);
  });

  tearDown(() {
    favoritesCubit.close();
  });

  group('FavoritesCubit', () {
    const mockLocation = GeocodingLocation(
      name: 'New York',
      lat: 40.7143,
      lon: -74.006,
      country: 'US',
      state: 'NY',
      localNames: LocalNames(),
    );

    final mockFavorite = Favorite(
      id: 1,
      location: mockLocation,
      date: DateTime(2024),
    );

    test('initial state is FavoritesState.initial', () {
      expect(favoritesCubit.state, FavoritesState.initial());
    });

    group('init', () {
      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, success] when favorites are loaded successfully',
        build: () {
          when(() => mockRepository.getFavorites())
              .thenAnswer((_) async => (null, [mockFavorite]));
          return favoritesCubit;
        },
        act: (cubit) => cubit.init(),
        expect: () => [
          FavoritesState.initial().copyWith(status: FavoritesStatus.loading),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.success,
            favorites: [mockFavorite],
          ),
        ],
      );

      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, failure] when loading favorites fails',
        build: () {
          const failure = Failure(message: 'Database error');
          when(() => mockRepository.getFavorites())
              .thenAnswer((_) async => (failure, null));
          return favoritesCubit;
        },
        act: (cubit) => cubit.init(),
        expect: () => [
          FavoritesState.initial().copyWith(status: FavoritesStatus.loading),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.failure,
            failure: const Failure(message: 'Database error'),
          ),
        ],
      );
    });

    group('removeFavorite', () {
      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, success] when favorite is removed successfully',
        build: () {
          when(() => mockRepository.removeFavorite(1))
              .thenAnswer((_) async => (null, true));
          return favoritesCubit;
        },
        seed: () => FavoritesState.initial().copyWith(
          status: FavoritesStatus.success,
          favorites: [mockFavorite],
        ),
        act: (cubit) => cubit.removeFavorite(1),
        expect: () => [
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.loading,
            favorites: [mockFavorite],
          ),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.success,
            favorites: <Favorite>[],
          ),
        ],
      );

      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, failure] when removing favorite fails',
        build: () {
          const failure = Failure(message: 'Remove failed');
          when(() => mockRepository.removeFavorite(1))
              .thenAnswer((_) async => (failure, null));
          return favoritesCubit;
        },
        act: (cubit) => cubit.removeFavorite(1),
        expect: () => [
          FavoritesState.initial().copyWith(status: FavoritesStatus.loading),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.failure,
            failure: const Failure(message: 'Remove failed'),
          ),
        ],
      );
    });

    group('addFavorite', () {
      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, success] when favorite is added successfully',
        build: () {
          when(() => mockRepository.addFavorite(any()))
              .thenAnswer((_) async => (null, true));
          when(() => mockRepository.getFavorites())
              .thenAnswer((_) async => (null, [mockFavorite]));
          return favoritesCubit;
        },
        act: (cubit) => cubit.addFavorite(mockLocation),
        expect: () => [
          FavoritesState.initial().copyWith(status: FavoritesStatus.loading),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.success,
            favorites: [mockFavorite],
          ),
        ],
      );

      blocTest<FavoritesCubit, FavoritesState>(
        'emits [loading, failure] when adding favorite fails',
        build: () {
          const failure = Failure(message: 'Add failed');
          when(() => mockRepository.addFavorite(any()))
              .thenAnswer((_) async => (failure, null));
          return favoritesCubit;
        },
        act: (cubit) => cubit.addFavorite(mockLocation),
        expect: () => [
          FavoritesState.initial().copyWith(status: FavoritesStatus.loading),
          FavoritesState.initial().copyWith(
            status: FavoritesStatus.failure,
            failure: const Failure(message: 'Add failed'),
          ),
        ],
      );
    });
  });
}
