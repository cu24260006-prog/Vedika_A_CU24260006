import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 1: Notes: insert and display
const sql='CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{final t=TextEditingController(),c=TextEditingController();List<Map<String,Object?>> rows=[];Future<Database> get db=>openDb('notes1.db',sql);
Future<void> load()async{final r=await (await db).query('notes');setState(()=>rows=r);}
Future<void> add()async{await (await db).insert('notes',{'title':t.text,'content':c.text});t.clear();c.clear();load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Notes')),body:Column(children:[TextField(controller:t,decoration:const InputDecoration(labelText:'Title')),TextField(controller:c,decoration:const InputDecoration(labelText:'Content')),ElevatedButton(onPressed:add,child:const Text('Add')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['title']}'),subtitle:Text('${r['content']}'))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
