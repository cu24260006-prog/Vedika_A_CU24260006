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

// Practical 16: Create DatabaseHelper Class

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'helper_students.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, roll_number TEXT, course TEXT)',
        );
      },
    );
    return _database!;
  }

  Future<int> insertStudent(Map<String, Object?> student) async {
    final db = await database;
    return db.insert('students', student);
  }

  Future<List<Map<String, Object?>>> getStudents() async {
    final db = await database;
    return db.query('students');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final helper = DatabaseHelper();
  await helper.insertStudent({'name': 'Aman', 'roll_number': '101', 'course': 'BCA'});
  print(await helper.getStudents());
}
