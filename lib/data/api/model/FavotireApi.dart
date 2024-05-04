class FavoriteApi {
  final String name;
  final int id;

  FavoriteApi({
    required this.name,
    required this.id,
  });

  FavoriteApi.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id_favorite'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id_favorite": id,
    };
  }
}
