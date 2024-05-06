class Favorite {
  final String name;
  final int id;
  final String type;

  Favorite({
    required this.name,
    required this.id,
    required this.type
  });

  Favorite.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'],
        type = map['type'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id_favorite": id,
      "type" : type,
    };
  }
}
