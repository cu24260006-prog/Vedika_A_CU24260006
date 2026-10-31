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

// Practical 17: Complete Student Record Management App

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: StudentHome());
}
class StudentHome extends StatefulWidget {
  const StudentHome({super.key});
  @override
  State<StudentHome> createState() => _StudentHomeState();
}
class _StudentHomeState extends State<StudentHome> {
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();
  List<Map<String, Object?>> students = [];
  @override
  void initState() { super.initState(); refresh(); }
  Future<void> refresh() async {
    final db = await openStudentDb();
    final rows = await db.query('students', orderBy: 'name');
    setState(() => students = rows);
  }
  Future<void> add() async {
    final db = await openStudentDb();
    await db.insert('students', {'name': name.text, 'roll_number': roll.text, 'course': course.text});
    name.clear(); roll.clear(); course.clear(); await refresh();
  }
  Future<void> delete(int id) async {
    final db = await openStudentDb();
    await db.delete('students', where: 'id = ?', whereArgs: [id]);
    await refresh();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Record Management')),
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number')),
        TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
        ElevatedButton(onPressed: add, child: const Text('Add Student')),
        Text('Total students: ${students.length}'),
        Expanded(child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, i) {
            final s = students[i];
            return ListTile(
              title: Text(s['name'].toString()),
              subtitle: Text('${s['roll_number']} - ${s['course']}'),
              trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => delete(s['id'] as int)),
            );
          },
        )),
      ]),
    ),
  );
}
void main() => runApp(const StudentApp());
