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

// Practical 7: Display Records Using rawQuery()

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await openStudentDb();
  final rows = await db.rawQuery('SELECT * FROM students');
  for (final row in rows) {
    print('Name: ${row['name']}, Roll: ${row['roll_number']}');
  }
  await db.close();
}
