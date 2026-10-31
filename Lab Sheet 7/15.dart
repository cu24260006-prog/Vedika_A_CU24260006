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

// Practical 15: Create Student Model Class

class Student {
  final int? id;
  final String name;
  final String rollNumber;
  final String course;

  Student({this.id, required this.name, required this.rollNumber, required this.course});

  Map<String, Object?> toMap() => {
    'id': id, 'name': name, 'roll_number': rollNumber, 'course': course,
  };

  factory Student.fromMap(Map<String, Object?> map) => Student(
    id: map['id'] as int?,
    name: map['name'] as String,
    rollNumber: map['roll_number'] as String,
    course: map['course'] as String,
  );
}

void main() {
  final student = Student(name: 'Aman', rollNumber: '101', course: 'BCA');
  print(student.toMap());
}
