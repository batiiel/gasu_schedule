part of 'group_bloc.dart';

class GroupState {
  final List<Group> groups;
  final bool isLoading;

  GroupState({
    this.groups = const [],
    this.isLoading = false,
  });
}
