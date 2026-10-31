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

// Practical 6: Display Records Using query() and ListView

class StudentListApp extends StatelessWidget {
  const StudentListApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: StudentListPage());
}
class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});
  Future<List<Map<String, Object?>>> getStudents() async {
    final db = await openStudentDb();
    return db.query('students');
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Students')),
    body: FutureBuilder<List<Map<String, Object?>>>(
      future: getStudents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final rows = snapshot.data!;
        if (rows.isEmpty) return const Center(child: Text('No records found'));
        return ListView.builder(
          itemCount: rows.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(rows[i]['name'].toString()),
            subtitle: Text('Roll: ${rows[i]['roll_number']} | ${rows[i]['course']}'),
          ),
        );
      },
    ),
  );
}
void main() => runApp(const StudentListApp());
