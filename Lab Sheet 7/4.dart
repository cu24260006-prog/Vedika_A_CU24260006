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

// Practical 4: Insert Records Using TextFields

class InsertStudentApp extends StatelessWidget {
  const InsertStudentApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: InsertStudentPage());
}
class InsertStudentPage extends StatefulWidget {
  const InsertStudentPage({super.key});
  @override
  State<InsertStudentPage> createState() => _InsertStudentPageState();
}
class _InsertStudentPageState extends State<InsertStudentPage> {
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();
  Future<void> save() async {
    final db = await openStudentDb();
    await db.insert('students', {
      'name': name.text, 'roll_number': roll.text, 'course': course.text,
    });
    name.clear(); roll.clear(); course.clear();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student saved')),
    );
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Insert Student')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number')),
        TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
        ElevatedButton(onPressed: save, child: const Text('Save')),
      ]),
    ),
  );
}
void main() => runApp(const InsertStudentApp());
