class Favorite {
  final String name;
  final int id;

  Favorite({
    required this.name,
    required this.id,
  });

  Favorite.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id_favorite": id,
    };
  }
}
