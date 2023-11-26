import 'dart:async';
import 'package:newsbook/database/table/article_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'news_database.db');
    var newsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return newsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(Article.createTable);
  }

}
