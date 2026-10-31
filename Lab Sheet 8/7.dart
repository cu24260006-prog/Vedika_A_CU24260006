import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 7: Search contacts using LIKE
const sql='CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('contacts3.db',sql);final q=TextEditingController();List<Map<String,Object?>> rows=[];
Future<void> search()async{final r=await (await db).query('contacts',where:'name LIKE ?',whereArgs:['%${q.text}%']);setState(()=>rows=r);}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Search Contacts')),body:Column(children:[TextField(controller:q,onChanged:(_)=>search(),decoration:const InputDecoration(labelText:'Search name')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('${r['phone']}'))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
