import 'dart:async';

import 'package:core/data/models/watchlist_table.dart';
import 'package:core/utils/encrypt.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblTvWatchlist = 'tv_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('dicoding123')
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblTvWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTable data, int type) async {
    final db = await database;

    return await db!
        .insert(type == 1 ? _tblWatchlist : _tblTvWatchlist, data.toJson());
  }

  Future<int> removeWatchlist(WatchlistTable data, int type) async {
    final db = await database;
    return await db!.delete(
      type == 1 ? _tblWatchlist : _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistById(int id, int type) async {
    final db = await database;
    final results = await db!.query(
      type == 1 ? _tblWatchlist : _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final results = await db!.query(_tblTvWatchlist);

    return results;
  }
}
