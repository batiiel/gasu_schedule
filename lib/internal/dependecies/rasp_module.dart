import 'package:gagu_schedule/internal/dependecies/repository_module.dart';
import 'package:gagu_schedule/domain/bloc/rasp_bloc/rasp_bloc.dart';

class RaspModule {
  static RaspBloc raspBloc() {
    return RaspBloc(RepositoryModule.raspRepository());
  }
}
