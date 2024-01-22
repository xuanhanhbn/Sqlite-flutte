import 'package:flutter/cupertino.dart';
import 'package:flutter_with_db/entity/student_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLHelper {
  // create table
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE  IF NOT EXISTS students(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  //create database
  static Future<Database> db() async {
    var factory = databaseFactoryFfiWeb;
    var db = await factory.openDatabase('my_db.db');
    await createTables(db);
    return db;
  }

  //insert data
  static Future<int> createItem(Student student) async {
    final db = await SQLHelper.db();

    final data = student.toMap();
    final id = await db.insert('students', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //get all data
  static Future<List<Student>> getItems() async {
    final db = await SQLHelper.db();
    List<Map<String, Object?>> data = await db.query('students');
    return data.map((e) => Student.valueFromJson(e)).toList();
  }

  //get by id
  static Future<Student> getItem(int id) async {
    final db = await SQLHelper.db();
    var data =
        await db.query('students', where: "id = ?", whereArgs: [id], limit: 1);
    return data.map((e) => Student.valueFromJson(e)).toList().first;
  }

  // Update an item by id
  static Future<int> updateItem(Student student) async {
    final db = await SQLHelper.db();

    final data = student.toMap();

    final result = await db
        .update('students', data, where: "id = ?", whereArgs: [student.id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("students", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
