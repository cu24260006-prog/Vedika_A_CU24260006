import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 8: Expense tracker: add and list
const sql='CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('expenses1.db',sql);final t=TextEditingController(),a=TextEditingController();List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('expenses');setState(()=>rows=r);}
Future<void> add()async{await (await db).insert('expenses',{'title':t.text,'amount':double.tryParse(a.text)??0});t.clear();a.clear();load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Expense Tracker')),body:Column(children:[TextField(controller:t,decoration:const InputDecoration(labelText:'Title')),TextField(controller:a,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Amount')),ElevatedButton(onPressed:add,child:const Text('Add Expense')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['title']}'),subtitle:Text('₹${r['amount']}'))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
