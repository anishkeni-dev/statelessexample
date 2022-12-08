import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'model/datamodel.dart';

class Userdb with ChangeNotifier{
  Future<Database> initDBUserData() async {
    //print("initialising db Cart");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "User.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );

  }

  Future<bool> insertUserData(UserModel user) async {
    final Database db = await initDBUserData();
    db.insert("UserTable", user.toMap());
    print("Inserting user" + user.name);
    notifyListeners();
    return true;
  }

  Future<List<Map<String, dynamic>>> getDataUserData() async {
    final Database db = await initDBUserData();
    final List<Map<String, dynamic?>> data = await db.query("UserTable");
    notifyListeners();
    return data;
  }

  Future<void> updateUserData(id, um) async {
    final db = await initDBUserData();
    await db.update(
      "UserTable",
      um.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

}