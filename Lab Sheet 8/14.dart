import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 14: Student list and add/edit using Navigator
const sql='CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT)';
class ListPage extends StatefulWidget{const ListPage({super.key});@override State<ListPage> createState()=>_L();}
class _L extends State<ListPage>{Future<Database> get db=>openDb('studentsnav.db',sql);List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('students');setState(()=>rows=r);}
Future<void> form([Map<String,Object?>? r])async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>FormPage(row:r)));load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Students')),floatingActionButton:FloatingActionButton(onPressed:()=>form(),child:const Icon(Icons.add)),body:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('${r['roll']}'),onTap:()=>form(r))).toList()));}
class FormPage extends StatefulWidget{final Map<String,Object?>? row;const FormPage({super.key,this.row});@override State<FormPage> createState()=>_F();}
class _F extends State<FormPage>{final n=TextEditingController(),r=TextEditingController();Future<Database> get db=>openDb('studentsnav.db',sql);
@override void initState(){super.initState();n.text='${widget.row?['name']??''}';r.text='${widget.row?['roll']??''}';}
Future<void> save()async{final d=await db;if(widget.row==null){await d.insert('students',{'name':n.text,'roll':r.text});}else{await d.update('students',{'name':n.text,'roll':r.text},where:'id=?',whereArgs:[widget.row!['id']]);}if(mounted)Navigator.pop(context);}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Add/Edit Student')),body:Column(children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Name')),TextField(controller:r,decoration:const InputDecoration(labelText:'Roll')),ElevatedButton(onPressed:save,child:const Text('Save'))]));}
void main()=>runApp(const MaterialApp(home:ListPage()));
