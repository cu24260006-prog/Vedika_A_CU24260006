import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 6: Delete contact with confirmation
const sql='CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('contacts2.db',sql);List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('contacts');setState(()=>rows=r);}
Future<void> remove(Map<String,Object?> r)async{final yes=await showDialog<bool>(context:context,builder:(_)=>AlertDialog(title:const Text('Delete contact?'),content:Text('${r['name']}'),actions:[TextButton(onPressed:()=>Navigator.pop(context,false),child:const Text('Cancel')),TextButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Delete'))]));if(yes==true){await (await db).delete('contacts',where:'id=?',whereArgs:[r['id']]);load();}}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Delete Contact')),body:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('${r['phone']}'),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>remove(r)))).toList()));}
void main()=>runApp(const MaterialApp(home:Page()));
