import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 5: Contact book: add and display
const sql='CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('contacts1.db',sql);final n=TextEditingController(),p=TextEditingController();List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('contacts');setState(()=>rows=r);}
Future<void> add()async{await (await db).insert('contacts',{'name':n.text,'phone':p.text});n.clear();p.clear();load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Contact Book')),body:Column(children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Name')),TextField(controller:p,decoration:const InputDecoration(labelText:'Phone')),ElevatedButton(onPressed:add,child:const Text('Save Contact')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('${r['phone']}'))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
