import 'dart:io';
import 'package:gagu_schedule/data/api/model/FavotireApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class FavoriteService {
  // FavoriteService._();
  // static final FavoriteService db = FavoriteService._();

  static Database? _database;

  Future<Database?> get database async {
    return _database ?? await initDB();
  }
  // Future<Database?> get database async {
  //   return await initDB();
  // }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FavoriteDB.db");
    return await openDatabase(path, version: 1, 
    onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE Favorite (
              id_favorite INTEGER unique,
              name TEXT
          )""");
    });
  }

  // Future<void> addFavorite(FavoriteApi favorite) async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, "FavoriteDB.db");
  //   print("22");
  //   await deleteDatabase(path);
  // }

  Future<void> addFavorite(FavoriteApi favorite) async {
    final db = await database;
    await db!.insert(
      "Favorite",
      favorite.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // getNote(int id) async {
  //   final db = await database;
  //   var res = await db!.query("Favorite", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? FavoriteApi.fromJson(res.first) : null;
  // }

  Future<List<FavoriteApi>> getListFavorite() async {
    final db = await database;
    var res = await db!.query("Favorite");
    List<FavoriteApi> list =
        res.isNotEmpty ? res.map((e) => FavoriteApi.fromJson(e)).toList() : [];
    return list;
  }

  // updateNote(FavoriteApi note) async {
  //   final db = await database;
  //   var res = await db!.update("Favorite", note.toJson(),
  //       where: "id = ?", whereArgs: [note.id]);
  //   return res;
  // }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db!.delete("Favorite", where: "id_favorite = ?", whereArgs: [id]);
    // updateIdTable(id);
  }

  // Future<void> updateIdTable(int id) async {
  //   final db = await database;
  //   var res = await db!.query("Favorite", where: "id > ?", whereArgs: [id]);
  //   List<FavoriteApi> list = res.map((e) => FavoriteApi.fromJson(e)).toList();
  //   for (FavoriteApi item in list) {
  //     db.update("Favorite", {'id': item.id - 1},
  //         where: "id = ?", whereArgs: [item.id]);
  //   }
  // }
}
