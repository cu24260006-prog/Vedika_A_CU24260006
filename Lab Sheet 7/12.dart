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

// Practical 12: Filter Students Using DropdownButton

class FilterApp extends StatelessWidget {
  const FilterApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: FilterPage());
}
class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  @override
  State<FilterPage> createState() => _FilterPageState();
}
class _FilterPageState extends State<FilterPage> {
  String course = 'BCA';
  Future<List<Map<String, Object?>>> load() async {
    final db = await openStudentDb();
    return db.query('students', where: 'course = ?', whereArgs: [course]);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Filter Students')),
    body: Column(children: [
      DropdownButton<String>(
        value: course,
        items: ['BCA', 'BBA', 'MCA'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => course = v!),
      ),
      Expanded(child: FutureBuilder(
        future: load(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(children: snapshot.data!.map((s) => ListTile(title: Text(s['name'].toString()))).toList());
        },
      )),
    ]),
  );
}
void main() => runApp(const FilterApp());
