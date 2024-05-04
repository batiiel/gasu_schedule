import 'package:dio/dio.dart';
import 'package:gagu_schedule/data/api/model/GroupApi.dart';
import 'package:gagu_schedule/data/api/model/RaspApi.dart';
import 'package:gagu_schedule/data/api/model/TeacherApi.dart';

class ServiceClient {
  final String urlGroups = 'https://stud.gasu.ru/api/raspGrouplist';
  final String urlTecahers = 'https://stud.gasu.ru/api/raspTeacherlist';

  //Берем список групп
  Future<List<GroupApi>> getGroupList() async {
    final Dio _dio = Dio();
    final response = await _dio.get(urlGroups);
    final maps = response.data["data"];
    return List.generate(maps.length, (index) => GroupApi.fromApi(maps[index]));
  }

  //получаем расписание
  Future<List<RaspApi>> getRasp({required String url}) async {
    final Dio _dio = Dio();
    final response = await _dio.get(url);
    final maps = response.data["data"]["rasp"];
    return List.generate(maps.length, (index) => RaspApi.fromApi(maps[index]));
  }

  //получаем список преподователей
  Future<List<TeacherApi>> getTeacherList() async {
    final Dio _dio = Dio();
    final response = await _dio.get(urlTecahers);
    final maps = response.data["data"];
    return List.generate(
        maps.length, (index) => TeacherApi.fromApi(maps[index]));
  }
}
