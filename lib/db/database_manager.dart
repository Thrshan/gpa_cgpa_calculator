// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modules/subject.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  DatabaseManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase("subject.db");
    return _database!;
  }

  Future<Database> _initDatabase(String dbFile) async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, dbFile);

    // ByteData data = await rootBundle.load(join("assets", "subject.db"));
    // List<int> bytes =
    //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // // Write and flush the bytes written
    // await File(path).writeAsBytes(bytes, flush: true);

    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const integerType = "INTEGER NOT NULL";
    const textType = "TEXT NOT NULL";
    db.execute('''
    CREATE TABLE $tableSubject (
      ${SubjectFields.id} $idType,
      ${SubjectFields.name} $textType,
      ${SubjectFields.code} $textType,
      ${SubjectFields.credit} $integerType
    )
    ''');
  }

  Future<Subject> create(Subject data) async {
    final db = await instance.database;

    final id = await db.insert(tableSubject, data.toMap());
    return data.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<Subject> readOne(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSubject,
      columns: SubjectFields.values,
      where: "${SubjectFields.id} = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Subject.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future readAll() async {
    final db = await instance.database;
    print("read all");
    return await db.rawQuery("SELECT * FROM genres");
  }

  Future<List<Subject>> readMany(int id) async {
    final db = await instance.database;
    final orderBy = "${SubjectFields.id} ASC";
    final result = await db.query(
      tableSubject,
      columns: SubjectFields.values,
      where: "${SubjectFields.id} = ?",
      whereArgs: [id],
      orderBy: orderBy,
    );
    if (result.isNotEmpty) {
      return result.map((row) => Subject.fromMap(row)).toList();
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(Subject subject, int id) async {
    final db = await instance.database;

    return await db.update(
      tableSubject,
      subject.toMap(),
      where: "${SubjectFields.id} = ?",
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSubject,
      where: "${SubjectFields.id} = ?",
      whereArgs: [id],
    );
  }
}


// Future<int> insert(Database db) async {
//   // Database database = _database;
//   await db.transaction((txn) async {
//     int id1 = await txn.rawInsert(
//         'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
//     print('inserted1: $id1');
//     int id2 = await txn.rawInsert(
//         'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
//         ['another name', 12345678, 3.1416]);
//     print('inserted2: $id2');
//   });
//   return 0;
// }
