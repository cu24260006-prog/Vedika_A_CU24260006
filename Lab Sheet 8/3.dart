import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 3: Swipe to delete note with SnackBar
const sql='CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('notes3.db',sql);List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('notes');setState(()=>rows=r);}
Future<void> remove(Map<String,Object?> r)async{await (await db).delete('notes',where:'id=?',whereArgs:[r['id']]);load();if(mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Note deleted')));}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Swipe to Delete')),body:ListView(children:rows.map((r)=>Dismissible(key:ValueKey(r['id']),onDismissed:(_)=>remove(r),background:Container(color:Colors.red),child:ListTile(title:Text('${r['title']}')))).toList()));}
void main()=>runApp(const MaterialApp(home:Page()));
