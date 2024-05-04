part of 'rasp_bloc.dart';

class RaspState {
  final bool isLoading;
  List<WeekDay> week;
  int indexWeek;

  RaspState({
    this.isLoading = false,
    this.week = const [],
    this.indexWeek = 0,
  });
}
