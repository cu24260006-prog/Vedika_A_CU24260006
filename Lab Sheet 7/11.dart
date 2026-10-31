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

// Practical 11: Search Student by Roll Number

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: SearchPage());
}
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  final roll = TextEditingController();
  String result = '';
  Future<void> search() async {
    final db = await openStudentDb();
    final rows = await db.query('students', where: 'roll_number = ?', whereArgs: [roll.text]);
    setState(() => result = rows.isEmpty ? 'Student not found' : rows.first.toString());
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Search Student')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number')),
        ElevatedButton(onPressed: search, child: const Text('Search')),
        Text(result),
      ]),
    ),
  );
}
void main() => runApp(const SearchApp());
