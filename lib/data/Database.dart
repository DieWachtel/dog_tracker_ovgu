import 'dart:convert';

import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/data/data.dart';
import 'package:tracker_app/data/walks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  factory DBProvider() => db;
  static Database? _database;

  //static Database _databaseQ;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'tracker_app.db'),
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, size TEXT
          )
        ''');
          await db.execute('''
          CREATE TABLE data (
            size TEXT, distance INTEGER
          )
          ''');
          await db.execute('''
          CREATE TABLE walks (
            id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL, distance INTEGER
          )
          ''');
        }, version: 4);
  }

  newUser(Dog newDog) async {
    final db = await (database as FutureOr<Database>);

    var res = await db.rawInsert('''
      INSERT INTO profile(
        name, age, size
      ) VALUES (?, ?, ?)
    ''', [newDog.name, newDog.age, newDog.size]);

    return res;
  }

  Future<Dog?> getUser(int id) async{
    final db = await (database as FutureOr<Database>);
    var result = await db.rawQuery('''
    SELECT * FROM profile WHERE id = ?''', [id]);
    if (result.length == 0) {
      print("getUser null");
      return null;}

    return Dog.fromJson(result.first);
  }

  newData(Data data) async{
    final db = await (database as FutureOr<Database>);

      var res = await db.rawInsert('''
        INSERT INTO data(
        size, distance
        ) VALUES (?, ?)
        ''', [data.size, data.distance]);

      return res;
  }

  Future<Data?> getData(String? size) async {
    var db = await (database as FutureOr<Database>);
    var result = await db.rawQuery('''
    SELECT * FROM data WHERE size = ?''', [size]);
    if (result.length == 0) return null;

    return Data.fromJson(result.first);
  }

  Future<int> changeName(String? name, String? oldname) async {
    var db = await (database as FutureOr<Database>);
    var changeName = await db.rawUpdate('''
    UPDATE profile SET name = ? WHERE name = ?
    ''', [name, oldname]);
    print('changed');

    return changeName;
  }

  Future<int> changeAge(int? age, String? name) async {
    var db = await (database as FutureOr<Database>);
    var changeAge = await db.rawUpdate('''
    UPDATE profile SET age = ? WHERE name = ?''', [age, name]);

    return changeAge;
  }

  Future<int> changeSize(String size, String? name) async {
    var db = await (database as FutureOr<Database>);
    var changeSize = await db.rawUpdate('''
    UPDATE profile SET size = ? WHERE name = ?''', [size, name]);

    return changeSize;
  }

  Future<int> deleteProfile() async {
    var db = await (database as FutureOr<Database>);
    int res = await db.delete("profile AND walks");
    return res;
  }

  newWalk(Walk newWalk) async {
    final db = await (database as FutureOr<Database>);

    var res = await db.rawInsert('''
      INSERT INTO walks(
        name, distance
      ) VALUES (?, ?)
    ''', [newWalk.name, newWalk.distance]);

    return res;
  }

  Future<String> getRecords(String name) async {
    var db = await (database as FutureOr<Database>);
    var resultRecords = await db.rawQuery('''
    SELECT count(id) FROM ques WHERE name = ?
    ''', [name]);
    if (resultRecords.length == 0) return "No Records available";

    return jsonEncode(resultRecords);
  }

  Future<String?> getDate(String name, int i) async {
    var db = await (database as FutureOr<Database>);
    var resultDate = await db.rawQuery('''
    SELECT date FROM walks WHERE name = ?''',
        [name]);
    if (resultDate.length == 0) return null;

    Map<dynamic, dynamic> map = resultDate[i];
    String? str = map["date"];

    return str;
  }

  Future<String?> getDistance(String name, int i) async {
    var db = await (database as FutureOr<Database>);
    var resultDistance = await db.rawQuery('''
    SELECT distance FROM walks WHERE name = ?''',
        [name]);
    if (resultDistance.length == 0) return null;

    Map<dynamic, dynamic> map = resultDistance[i];
    String? str = map["distance"];

    return str;
  }
}
