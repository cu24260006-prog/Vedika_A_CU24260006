import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 12: Login validation with SQLite
const sql='CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,password TEXT)';
class Login extends StatefulWidget{const Login({super.key});@override State<Login> createState()=>_S();}
class _S extends State<Login>{Future<Database> get db=>openDb('login.db',sql);final e=TextEditingController(),p=TextEditingController();String msg='';
Future<void> check()async{final r=await (await db).query('users',where:'email=? AND password=?',whereArgs:[e.text,p.text]);setState(()=>msg=r.isEmpty?'Invalid login':'Login successful');}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Login')),body:Column(children:[TextField(controller:e,decoration:const InputDecoration(labelText:'Email')),TextField(controller:p,obscureText:true,decoration:const InputDecoration(labelText:'Password')),ElevatedButton(onPressed:check,child:const Text('Login')),Text(msg)]));}
void main()=>runApp(const MaterialApp(home:Login()));
