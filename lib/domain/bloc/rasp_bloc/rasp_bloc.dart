import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/domain/model/WeekDay.dart';
import 'package:gagu_schedule/domain/repository/rasp_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'rasp_event.dart';
part 'rasp_state.dart';

class RaspBloc extends Bloc<RaspEvent, RaspState> {
  final RaspRepository raspRepository;
  late List<WeekDay> week;

  RaspBloc(this.raspRepository) : super(RaspState()) {
    on<GetRaspEvent>(_onGetRasp);
    on<SetIndexEvent>(_onSetIndex);
  }
  _onGetRasp(GetRaspEvent event, Emitter<RaspState> emit) async {
    emit(RaspState(isLoading: true));
    DateTime now = DateTime.parse(event.date);
    int index = now.weekday - 1;
    String strDate = getDate(event.date, now);
    List<Rasp> rasp;
    switch(event.type){
      case TypeRasp.group:
        rasp =  await raspRepository.getRaspGroup(event.id, strDate);
        break;
      case TypeRasp.teacher:
        rasp =  await raspRepository.getRaspTeacher(event.id, strDate);
        break;
    }

    List<WeekDay> week = getListWeekDay(rasp, now);

    emit(RaspState(week: week, indexWeek: index));
  }

  List<WeekDay> getListWeekDay(List<Rasp> rasp,DateTime now){
    
    week = List.generate(6, (i) {
      DateTime newTime =
          DateTime(now.year, now.month, now.day + i - now.weekday + 1);
      final List<Rasp> raspDay = [];
      for (final item in rasp) {
        if (item.day == newTime.day.toString()) {
          raspDay.add(item);
        }
      }
      return WeekDay(
          weekDay: DateFormat.E('ru').format(newTime),
          day: newTime.day.toString(),
          rasp: raspDay);
    });
    return week;
  }

 String getDate(String date, DateTime now){
    String strDate = DateFormat('yyyy-MM-dd').format(now);
    if (now.weekday == 7) {
      now = DateTime(now.year, now.month, now.day - 6);
      strDate = DateFormat('yyyy-MM-dd').format(now);
    }
    return strDate;
  }

  _onSetIndex(SetIndexEvent event, Emitter<RaspState> emit) {
    emit(RaspState(week: week, indexWeek: event.index));
  }
}
