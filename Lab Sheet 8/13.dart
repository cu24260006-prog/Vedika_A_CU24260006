import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 13: Form validation before insert
const sql='CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{final k=GlobalKey<FormState>();final n=TextEditingController(),e=TextEditingController();Future<Database> get db=>openDb('validated.db',sql);
Future<void> save()async{if(k.currentState!.validate()){await (await db).insert('users',{'name':n.text,'email':e.text});if(mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Saved')));}}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Validated Form')),body:Form(key:k,child:Column(children:[TextFormField(controller:n,decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.isEmpty?'Enter name':null),TextFormField(controller:e,decoration:const InputDecoration(labelText:'Email'),validator:(v)=>v==null||!v.contains('@')?'Enter valid email':null),ElevatedButton(onPressed:save,child:const Text('Save'))])));}
void main()=>runApp(const MaterialApp(home:Page()));
