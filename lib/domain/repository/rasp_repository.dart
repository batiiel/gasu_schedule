import 'package:gagu_schedule/domain/model/Rasp.dart';

abstract class RaspRepository {
  Future<List<Rasp>> getRaspGroup(int id, String date);
  Future<List<Rasp>> getRaspTeacher(int id, String date);
}
