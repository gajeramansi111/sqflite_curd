// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
//
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'model.dart';

import 'dart:io' as io;
import 'package:path/path.dart';

//
// class SQLHElpers {
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""" CREAT TABLE items(
//     id INTEGER,
//     title TEXT,
//     decripation TEXT,
//     created TIMESTAMP NOT NULLDEFAULT)""");
//   }
//
//   static Future<sql.Database> db() async {return sql.openDatabase(path)}
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_widget/database.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static const dbName = "myDatabase.db";
//   static const dbVersion = 1;
//   static const dbTable = "myTable";
//   static const ColumnId = "id";
//   static const ColumnName = "name";
//
//   static final DatabaseHelper instance = DatabaseHelper();
//
//   static Database? database;
//
//   Future<Database?> get data async {
//     if (database != null) return database;
//   }
// }

class DBHelper {
  static Database? _db;

  Future<Database?> get data async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY autoincrement, title TEXT,'
      'description TEXT NOT NULL,image IMAGE NOT NULL,audio AUDIO NOT NULL )',
    );
  }

  Future<NotesModel> insertData(NotesModel noteModel) async {
    var dbClient = await data;
    print('Payload== ${noteModel.toMap()}');
    await dbClient!
        .insert('notes', noteModel.toMap())
        .then((value) => print("Value !!!!!! $value"))
        .catchError((onError) {
      print("onError $onError");
    });
    return noteModel;
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await data;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');

    print("queryResult $queryResult");
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await data;
    return await dbClient!.delete('notes', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(NotesModel notesModel) async {
    var dbClient = await data;
    return await dbClient!.update('notes', notesModel.toMap(),
        where: 'id=?', whereArgs: [notesModel.id]);
  }
}
