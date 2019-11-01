import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:clima/models/ciudad_model.dart';

class DatabaseHelper {

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'clima.db';
   // await deleteDatabase(path);

    // Open/create the database at a given path
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int version) async {
    //String sql = ;
    await db.execute("create table " + Ciudad.tableName + "(" +
        Ciudad.idName + " TEXT PRIMARY KEY," +
        Ciudad.nombreName + " TEXT NOT NULL," +
        Ciudad.descripcionName + " TEXT NOT NULL," +
        Ciudad.latName + " TEXT," +
        Ciudad.lonName + " TEXT," +
        Ciudad.climaName + " TEXT," +
        Ciudad.fechaName + " TEXT )");
  }


  Future<int> truncarTabla(String table) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $table');
    return result;
  }
}



