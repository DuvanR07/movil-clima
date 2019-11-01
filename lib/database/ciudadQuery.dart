import 'package:clima/database/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:clima/models/ciudad_model.dart';

class CiudadQuery extends DatabaseHelper {
  // Insert Operation: Insert a Note object to database
  Future<int> insertCiudad(Ciudad ciudad) async {
    Database db = await this.database;
    var result = await db.insert(Ciudad.tableName, ciudad.toMap());
    return result;
  }

  Future<List<Ciudad>> getCiudades() async {
    Database db = await this.database;
    var productoMapList =
        await db.rawQuery("SELECT * FROM " + Ciudad.tableName);

    List<Ciudad> productoList = List<Ciudad>();
    for (int i = 0; i < productoMapList.length; i++) {
      productoList.add(Ciudad.fromMapObject(productoMapList[i]));
    }

    print("CAN: ${productoList.length}");
    return productoList;
  }

  Future<dynamic> getCiudad(String id) async {

    final ciudad = new Ciudad(id: null);
    Database db = await this.database;
    var res = await db.query(Ciudad.tableName,
        where: "${Ciudad.idName} = ?", whereArgs: [id]);
    return res.isNotEmpty ? Ciudad.fromMapObject(res.first) : null;
  }

  Future<int> deleteCiudad(String id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        "DELETE FROM ${Ciudad.tableName} WHERE ${Ciudad.idName} = '$id'");
    return result;
  }

  Future<int> updateCiudad(Ciudad ciudad) async {
    var db = await this.database;
    var result = await db.update(Ciudad.tableName, ciudad.toMap(),
        where: Ciudad.idName + ' = ?', whereArgs: [ciudad.id]);
    return result;
  }
}
