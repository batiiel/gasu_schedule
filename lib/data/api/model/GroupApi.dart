// ignore_for_file: file_names
class GroupApi {
  final String name;
  final int id;
  final String facul;

  GroupApi({
    required this.name,
    required this.id,
    required this.facul,
  });

  GroupApi.fromApi(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'],
        facul = map['facul'];
}
