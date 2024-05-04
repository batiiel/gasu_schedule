class Group {
  final String name;
  final int id;
  final String facul;

  Group({
    required this.name,
    required this.id,
    required this.facul,
  });

  Group.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'],
        facul = map['facul'];
}
