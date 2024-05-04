import 'package:gagu_schedule/domain/model/Favorite.dart';

abstract class FavoriteRepository {
  Future<List<Favorite>> getFavoriteList();
  Future<void> addFavorite(Favorite item);
  Future<void> deleteFavorite(int id);
}
