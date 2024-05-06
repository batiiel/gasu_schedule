class FavoriteApi {
  final String name;
  final int id;
  final String type;

  FavoriteApi({
    required this.name,
    required this.id,
    required this.type,
  });

  FavoriteApi.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id_favorite'],
        type = map['type'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id_favorite": id,
      "type" : type,
    };
  }
}
