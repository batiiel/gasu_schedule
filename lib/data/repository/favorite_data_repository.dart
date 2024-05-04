import 'package:gagu_schedule/data/api/apiUtil.dart';
import 'package:gagu_schedule/domain/model/Favorite.dart';
import 'package:gagu_schedule/domain/repository/favorite_repository.dart';

class FavoriteDataRepository extends FavoriteRepository {
  final ApiUtil apiUtil;

  FavoriteDataRepository(this.apiUtil);

  @override
  Future<List<Favorite>> getFavoriteList() {
    return apiUtil.getListFavorite();
  }

  @override
  Future<void> addFavorite(Favorite item) async {
    await apiUtil.addFavorite(item);
  }

  @override
  Future<void> deleteFavorite(int id) async {
    await apiUtil.deleteFavorite(id);
  }
}
