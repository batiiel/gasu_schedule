class RaspApi {
  final String weekday;
  final String discipline;
  final String group;
  final String teacher;
  final String classroom;
  final String start_time;
  final String end_time;
  final String date;

  RaspApi({
    required this.weekday,
    required this.discipline,
    required this.group,
    required this.teacher,
    required this.classroom,
    required this.start_time,
    required this.end_time,
    required this.date,
  });

  RaspApi.fromApi(Map<String, dynamic> map)
      : weekday = map['день_недели'],
        discipline = map['дисциплина'],
        group = map['группа'],
        teacher = map['преподаватель'],
        classroom = map['аудитория'],
        start_time = map['начало'],
        end_time = map['конец'],
        date = map['дата'];
}
