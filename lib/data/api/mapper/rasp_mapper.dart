import 'package:flutter/material.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/data/api/model/RaspApi.dart';

import 'package:intl/intl.dart';

class RaspMapper {
  static Rasp fromApi(RaspApi rasp) {
    return Rasp(
      weekDay: getWeekDay(rasp.date),
      discipline: rasp.discipline,
      group: rasp.group,
      teacher: rasp.teacher,
      classroom: rasp.classroom,
      start_time: rasp.start_time,
      end_time: rasp.end_time,
      color: getColor(rasp.discipline.substring(0, 2)),
      day: getDay(rasp.date),
      // weekDay: getWeekDay(rasp.date),
    );
  }

  static getDay(String date) {
    return DateFormat.d('ru').format(DateTime.parse(date));
  }

  static getWeekDay(String date) {
    return DateFormat.E('ru').format(DateTime.parse(date));
  }

  static Color getColor(String type) {
    switch (type) {
      case "пр":
        return ColorApp.textPrac;
      case "ла":
        return ColorApp.textLab;
      case "ко":
        return ColorApp.textKont;
      case "эк":
        return ColorApp.textExam;
    }
    return ColorApp.textDefault;
  }
}
