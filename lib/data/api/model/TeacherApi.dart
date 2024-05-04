// ignore_for_file: file_names
class TeacherApi {
  final String name;
  final int id;

  TeacherApi({
    required this.name,
    required this.id,
  });

  TeacherApi.fromApi(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'];
}
