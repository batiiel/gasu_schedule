import 'package:flutter/material.dart';

class Rasp {
  final String weekDay;
  final String discipline;
  final String group;
  final String teacher;
  final String classroom;
  final String start_time;
  final String end_time;
  final Color color;
  final String day;
  // final String weekDay;

  Rasp({
    required this.weekDay,
    required this.discipline,
    required this.group,
    required this.teacher,
    required this.classroom,
    required this.start_time,
    required this.end_time,
    required this.color,
    required this.day,
    // required this.weekDay,
  });
}

 //    s = "\nПредмет: " + str(par['дисциплина'])
  // + "\nВремя: " + str(par['часы'].replace('\n', '-'))
  // + "\nПреподователь: " + str(par['преподаватель'])
  // + "\nАудитория: " + str(par['аудитория'])
  //+ "\nДата: " + str(par['дата'].split('T')[0]) + "\n"