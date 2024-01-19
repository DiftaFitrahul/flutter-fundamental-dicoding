import 'package:sqflite/sqflite.dart';

import '../model/restaurant.dart';

class FavoritesDB {
  static FavoritesDB? _favoritesDB;
  static Database? _database;

  FavoritesDB._internal() {
    _favoritesDB = this;
  }

  factory FavoritesDB() => _favoritesDB ?? FavoritesDB._internal();

  static const String _tblFavorites = 'favorites';

  Future<Database> _initializeDB() async {
    final path = await getDatabasesPath();
    final db = openDatabase('$path/restaurantapp.db',
        onCreate: _onCreateTable, version: 1);
    return db;
  }

  Future<void> _onCreateTable(Database db, int _) async {
    await db.execute(
      '''
          CREATE TABLE $_tblFavorites(
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL 
          )
    ''',
    );
  }

  Future<Database?> get database async {
    _database ??= await _initializeDB();
    return _database;
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;

    final result = await db!.query(_tblFavorites);

    return result.map((restaurant) => Restaurant.fromJson(restaurant)).toList();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorites, restaurant.toJson());
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(_tblFavorites, where: 'id = ?', whereArgs: [id]);
  }
}
