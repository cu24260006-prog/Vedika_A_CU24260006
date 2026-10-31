import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 2: Edit notes
const sql='CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('notes2.db',sql);List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('notes');setState(()=>rows=r);}
Future<void> edit(Map<String,Object?> r)async{final t=TextEditingController(text:'${r['title']}'),c=TextEditingController(text:'${r['content']}');await showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Edit note'),content:Column(mainAxisSize:MainAxisSize.min,children:[TextField(controller:t),TextField(controller:c)]),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),TextButton(onPressed:()async{await (await db).update('notes',{'title':t.text,'content':c.text},where:'id=?',whereArgs:[r['id']]);if(mounted)Navigator.pop(context);load();},child:const Text('Save'))]));}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Edit Notes')),body:ListView(children:rows.map((r)=>ListTile(title:Text('${r['title']}'),subtitle:Text('${r['content']}'),onTap:()=>edit(r))).toList()));}
void main()=>runApp(const MaterialApp(home:Page()));
