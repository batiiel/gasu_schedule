part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class GetGroupsEvent extends GroupEvent {}

class SearchGroupEvent extends GroupEvent {
  final String query;

  SearchGroupEvent({required this.query});
}
