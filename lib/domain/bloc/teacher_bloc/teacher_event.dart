part of 'teacher_bloc.dart';

@immutable
abstract class TeacherEvent {}

class GetTeacherEvent extends TeacherEvent {}

class SearchTeacherEvent extends TeacherEvent {
  final String query;

  SearchTeacherEvent({required this.query});
}
