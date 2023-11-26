import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../localdb.dart';

class Article {
  // table name
  static const String articles = "articles";


  // columns

  static const String source = "source";
  static const String id = "id";
  static const String name = "name";
  static const String author = "author";
  static const String title = "title";
  static const String description = "description";
  static const String url = "url";
  static const String urlToImage = "urlToImage";
  static const String publishedAt = "publishedAt";
  static const String content = "content";
  static const String totalResults = "totalResults";


  static const String createTable = "CREATE TABLE IF NOT EXISTS $articles ("
      "$source TEXT DEFAULT '', "
      "$id TEXT DEFAULT '', "
      "$name TEXT DEFAULT '', "
      "$author TEXT DEFAULT '', "
      "$title TEXT DEFAULT '', "
      "$description TEXT DEFAULT '', "
      "$url TEXT DEFAULT '', "
      "$urlToImage TEXT DEFAULT '', "
      "$publishedAt TEXT DEFAULT '', "
      "$totalResults TEXT DEFAULT '')";


  Future<void> insert(Map<String, dynamic> map) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    // Get a reference to the database.
    final db = await databaseHelper.database;
    //dynamic batch = db.batch();
    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same userInfo is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      articles,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> deleteTable() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    // Get a reference to the database.
    final db = await databaseHelper.database;
    await db.delete(articles);
  }
  // A method that retrieves all the userInfo from the userInfo table.
  Future<List<Map<String, dynamic>>> userInfo() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    // Get a reference to the database.
    final db = await databaseHelper.database;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await db.query(articles);

    //getDivisions();
    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return maps;//List.generate(maps.length, (index) => Breed.fromMap(maps[index]));
  }

}