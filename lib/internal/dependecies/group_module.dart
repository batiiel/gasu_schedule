import 'package:gagu_schedule/internal/dependecies/repository_module.dart';
import 'package:gagu_schedule/domain/bloc/group_bloc/group_bloc.dart';

class GroupModule {
  static GroupBloc groupBloc() {
    return GroupBloc(RepositoryModule.groupRepository());
  }
}
