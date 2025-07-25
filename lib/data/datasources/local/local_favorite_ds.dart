import 'package:climora/core/db/database_helper.dart';
import 'package:climora/core/error/failure.dart';
import 'package:climora/data/model/favorite_model.dart';

abstract class LocalFavoriteDS {
  Future<List<FavoriteModel>> getFavorites();
  Future<bool> addFavorite(FavoriteModel favorite);
  Future<bool> removeFavorite(int favoriteId);
}

class LocalFavoriteDSI implements LocalFavoriteDS {
  LocalFavoriteDSI({required this.db});

  final DatabaseHelper db;

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final response = await DatabaseHelper.instance.readAllFavorites();
      final favorites = response.map(FavoriteModel.fromMap).toList();
      return favorites;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const Failure(message: 'Error desconocido');
    }
  }

  @override
  Future<bool> addFavorite(FavoriteModel favorite) async {
    await DatabaseHelper.instance.create(favorite.toMapForInsert());
    return true;
  }

  @override
  Future<bool> removeFavorite(int favoriteId) async {
    await DatabaseHelper.instance.delete(favoriteId);
    return true;
  }
}
