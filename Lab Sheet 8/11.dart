import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 11: User registration
const sql='CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('register.db',sql);final n=TextEditingController(),e=TextEditingController(),p=TextEditingController();String msg='';
Future<void> save()async{await (await db).insert('users',{'name':n.text,'email':e.text,'password':p.text});setState(()=>msg='Registration successful');}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Registration')),body:Column(children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Name')),TextField(controller:e,decoration:const InputDecoration(labelText:'Email')),TextField(controller:p,obscureText:true,decoration:const InputDecoration(labelText:'Password')),ElevatedButton(onPressed:save,child:const Text('Register')),Text(msg)]));}
void main()=>runApp(const MaterialApp(home:Page()));
