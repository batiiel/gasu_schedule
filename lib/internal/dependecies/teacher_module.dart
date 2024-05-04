import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/repository_module.dart';

class TeacherModule {
  static TeacherBloc teacherBloc() {
    return TeacherBloc(RepositoryModule.teacherRepository());
  }
}
