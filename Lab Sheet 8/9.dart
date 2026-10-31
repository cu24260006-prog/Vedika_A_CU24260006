import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 9: Total expenses using SQL SUM
const sql='CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('expenses2.db',sql);double total=0;
Future<void> load()async{final r=await (await db).rawQuery('SELECT SUM(amount) AS total FROM expenses');setState(()=>total=(r.first['total'] as num?)?.toDouble()??0);}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Total Expense')),body:Center(child:Text('Total Expense: ₹${total.toStringAsFixed(2)}',style:const TextStyle(fontSize:24))));}
void main()=>runApp(const MaterialApp(home:Page()));
