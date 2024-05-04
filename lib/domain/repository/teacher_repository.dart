import 'package:gagu_schedule/domain/model/Teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeacherList();
}
