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

// Practical 3: Insert Record Using insert()

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await openStudentDb();
  final id = await db.insert('students', {
    'name': 'Aman',
    'roll_number': '101',
    'course': 'BCA',
  });
  print('Record inserted with ID: $id');
  await db.close();
}
