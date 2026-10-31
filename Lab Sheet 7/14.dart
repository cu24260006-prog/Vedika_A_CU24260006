import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openStudentDb() async {
  final dbPath = await getDatabasesPath();
  return openDatabase(
    join(dbPath, 'students.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, roll_number TEXT, course TEXT)',
      );
    },
  );
}

// Practical 14: Count Total Records

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await openStudentDb();
  final result = await db.rawQuery('SELECT COUNT(*) AS total FROM students');
  final total = Sqflite.firstIntValue(result) ?? 0;
  print('Total students: $total');
  await db.close();
}
