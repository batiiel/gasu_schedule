import 'package:gagu_schedule/data/repository/favorite_data_repository.dart';
import 'package:gagu_schedule/data/repository/group_data_repository.dart';
import 'package:gagu_schedule/data/repository/rasp_data_repository.dart';
import 'package:gagu_schedule/data/repository/teacher_data_repository.dart';
import 'package:gagu_schedule/domain/repository/favorite_repository.dart';
import 'package:gagu_schedule/domain/repository/group_repository.dart';
import 'package:gagu_schedule/domain/repository/rasp_repository.dart';
import 'package:gagu_schedule/domain/repository/teacher_repository.dart';
import 'package:gagu_schedule/internal/dependecies/api_module.dart';

class RepositoryModule {
  static late GroupRepository _groupRepositoty;
  static late RaspRepository _raspRepository;
  static late TeacherRepository _teacherRepository;
  static late FavoriteRepository _favoriteRepository;

  static GroupRepository groupRepository() {
    _groupRepositoty = GroupDataRepository(ApiModule.apiUtil());
    return _groupRepositoty;
  }

  static RaspRepository raspRepository() {
    _raspRepository = RaspDataRepository(ApiModule.apiUtil());
    return _raspRepository;
  }

  static TeacherRepository teacherRepository() {
    _teacherRepository = TeacherDataRepository(ApiModule.apiUtil());
    return _teacherRepository;
  }

  static FavoriteRepository favoriteRepository() {
    _favoriteRepository = FavoriteDataRepository(ApiModule.apiUtil());
    return _favoriteRepository;
  }
}
