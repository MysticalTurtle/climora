import 'package:climora/core/core.dart';
import 'package:climora/data/datasources/local/local_favorite_ds.dart';
import 'package:climora/data/datasources/local/local_weather_ds.dart';
import 'package:climora/data/datasources/remote/remote_weather_ds.dart';
import 'package:climora/data/repositories/favorites_repository_i.dart';
import 'package:climora/data/repositories/weather_repository_i.dart';
import 'package:climora/domain/repositories/favorites_repository.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> init({required Dio dio, required String apiKey}) async {
  sl
    // Services
    ..registerLazySingleton<LocationService>(
      LocationServiceI.new,
    )
    // Repository
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryI(
        remoteDS: sl(),
        localDS: sl(),
      ),
    )
    ..registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryI(
        localDS: sl(),
      ),
    )
    // Data sources
    ..registerLazySingleton<LocalFavoriteDS>(
      () => LocalFavoriteDSI(db: DatabaseHelper.instance),
    )
    ..registerLazySingleton<LocalWeatherDS>(
      () => LocalWeatherDSI(db: DatabaseHelper.instance),
    )
    ..registerLazySingleton<RemoteWeatherDS>(
      () => RemoteWeatherDSI(dio: dio, apiKey: apiKey),
    );
}
