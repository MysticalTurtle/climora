import 'dart:convert';

import 'package:climora/core/error/failure.dart';
import 'package:climora/data/datasources/local/local_favorite_ds.dart';
import 'package:climora/data/model/favorite_model.dart';
import 'package:climora/domain/entities/favorite.dart';
import 'package:climora/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryI extends FavoritesRepository {
  FavoritesRepositoryI({
    required this.localDS,
  });

  final LocalFavoriteDS localDS;

  @override
  Future<(Failure?, List<Favorite>?)> getFavorites() async {
    try {
      final favoritesModel = await localDS.getFavorites();
      final favoriteEntities = favoritesModel.map((favoriteModel) {
        final favoriteMap =
            jsonDecode(favoriteModel.json) as Map<String, dynamic>;
        // Use the database ID, not the one from JSON
        favoriteMap['id'] = favoriteModel.id;
        return Favorite.fromMap(favoriteMap);
      }).toList();
      return (null, favoriteEntities);
    } on Failure {
      rethrow;
    } on FormatException {
      return (const Failure(message: 'Formato incorrecto'), null);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }

  @override
  Future<(Failure?, bool?)> addFavorite(Favorite favorite) async {
    try {
      final favoriteModel = FavoriteModel(
        id: 0, // Will be ignored in insert, database auto-generates
        json: jsonEncode(favorite.toMap()),
        dateTime: DateTime.now().toIso8601String(),
      );
      await localDS.addFavorite(favoriteModel);
      return (null, true);
    } on Failure {
      rethrow;
    } on FormatException {
      return (const Failure(message: 'Formato incorrecto'), null);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }

  @override
  Future<(Failure?, bool?)> removeFavorite(int favoriteId) async {
    try {
      await localDS.removeFavorite(favoriteId);
      return (null, true);
    } on Failure {
      rethrow;
    } on FormatException {
      return (const Failure(message: 'Formato incorrecto'), null);
    } catch (e) {
      if (e is Failure) {
        return (e, null);
      }
      return (const Failure(message: 'Error desconocido'), null);
    }
  }
}
