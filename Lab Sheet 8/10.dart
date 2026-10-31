import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 10: To-do app with checkbox
const sql='CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,completed INTEGER)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('todo.db',sql);final t=TextEditingController();List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('tasks');setState(()=>rows=r);}
Future<void> add()async{await (await db).insert('tasks',{'title':t.text,'completed':0});t.clear();load();}
Future<void> toggle(Map<String,Object?> r,bool? v)async{await (await db).update('tasks',{'completed':v==true?1:0},where:'id=?',whereArgs:[r['id']]);load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('To-Do List')),body:Column(children:[TextField(controller:t,decoration:const InputDecoration(labelText:'Task')),ElevatedButton(onPressed:add,child:const Text('Add Task')),Expanded(child:ListView(children:rows.map((r)=>CheckboxListTile(title:Text('${r['title']}'),value:r['completed']==1,onChanged:(v)=>toggle(r,v))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
