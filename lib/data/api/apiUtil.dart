import 'package:gagu_schedule/data/api/model/FavotireApi.dart';
import 'package:gagu_schedule/data/api/service/servie_client.dart';
import 'package:gagu_schedule/data/api/service/sql_service.dart';
import 'package:gagu_schedule/domain/model/Favorite.dart';

import 'package:gagu_schedule/domain/model/Group.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';

import 'package:gagu_schedule/data/api/mapper/rasp_mapper.dart';
import 'package:gagu_schedule/domain/model/Teacher.dart';

class ApiUtil {
  final ServiceClient serviceClient;
  final FavoriteService sqlService;

  ApiUtil(this.serviceClient, this.sqlService);

  Future<List<Group>> getGroupList() async {
    final result = await serviceClient.getGroupList();
    return List.generate(
        result.length,
        (index) => Group(
              name: result[index].name,
              id: result[index].id,
              facul: result[index].facul,
            ));
  }

  Future<List<Rasp>> getRasp(String url) async {
    final result = await serviceClient.getRasp(url: url);
    return List.generate(
        result.length, (index) => RaspMapper.fromApi(result[index]));
  }

  Future<List<Teacher>> getTeacherList() async {
    final result = await serviceClient.getTeacherList();
    return List.generate(
        result.length,
        (index) => Teacher(
              id: result[index].id,
              name: result[index].name,
            ));
  }

  //Работа с БД

  Future<List<Favorite>> getListFavorite() async {
    final restul = await sqlService.getListFavorite();
    return List.generate(restul.length,
        (index) => Favorite(name: restul[index].name, id: restul[index].id, type: restul[index].type));
  }

  Future<void> addFavorite(Favorite item) async {
    sqlService.addFavorite(FavoriteApi(name: item.name, id: item.id, type: item.type));
  }

  Future<void> deleteFavorite(int id) async {
    sqlService.deleteFavorite(id);
  }
}
