import 'package:climora/core/error/failure.dart';
import 'package:climora/domain/entities/favorite.dart';

abstract class FavoritesRepository {
  Future<(Failure?, List<Favorite>?)> getFavorites();
  Future<(Failure?, bool?)> addFavorite(Favorite favorite);
  Future<(Failure?, bool?)> removeFavorite(int favoriteId);
}
