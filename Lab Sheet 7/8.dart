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

// Practical 8: Update Student Record

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await openStudentDb();
  final count = await db.update(
    'students',
    {'course': 'BCA (Updated)'},
    where: 'roll_number = ?',
    whereArgs: ['101'],
  );
  print('$count record(s) updated');
  await db.close();
}
