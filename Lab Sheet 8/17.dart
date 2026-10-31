import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 17: Student management app with screens and validation
const sql='CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT)';
class Home extends StatelessWidget{const Home({super.key});@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Student Management')),body:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[ElevatedButton(onPressed:()=>Navigator.push(x,MaterialPageRoute(builder:(_)=>const AddPage())),child:const Text('Add Student')),ElevatedButton(onPressed:()=>Navigator.push(x,MaterialPageRoute(builder:(_)=>const StudentsPage())),child:const Text('View Students'))])));}
class AddPage extends StatefulWidget{const AddPage({super.key});@override State<AddPage> createState()=>_A();}
class _A extends State<AddPage>{final k=GlobalKey<FormState>();final n=TextEditingController(),r=TextEditingController();Future<Database> get db=>openDb('studentmanagement.db',sql);
Future<void> save()async{if(k.currentState!.validate()){await (await db).insert('students',{'name':n.text,'roll':r.text});if(mounted)Navigator.pop(context);}}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Add Student')),body:Form(key:k,child:Column(children:[TextFormField(controller:n,decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.isEmpty?'Enter name':null),TextFormField(controller:r,decoration:const InputDecoration(labelText:'Roll'),validator:(v)=>v==null||v.isEmpty?'Enter roll':null),ElevatedButton(onPressed:save,child:const Text('Save'))])));}
class StudentsPage extends StatefulWidget{const StudentsPage({super.key});@override State<StudentsPage> createState()=>_V();}
class _V extends State<StudentsPage>{Future<Database> get db=>openDb('studentmanagement.db',sql);List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('students');setState(()=>rows=r);}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Student Records')),body:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('${r['roll']}'))).toList()));}
void main()=>runApp(const MaterialApp(home:Home()));
