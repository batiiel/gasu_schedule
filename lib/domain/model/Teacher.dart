class Teacher {
  final String name;
  final int id;

  Teacher({
    required this.name,
    required this.id,
  });

  Teacher.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'];
}
