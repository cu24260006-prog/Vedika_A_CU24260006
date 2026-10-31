import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 15: Product inventory CRUD
const sql='CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,quantity INTEGER,price REAL)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('inventory.db',sql);final n=TextEditingController(),q=TextEditingController(),p=TextEditingController();List<Map<String,Object?>> rows=[];
Future<void> load()async{final r=await (await db).query('products');setState(()=>rows=r);}
Future<void> save([Map<String,Object?>? r])async{final d=await db;final v={'name':n.text,'quantity':int.tryParse(q.text)??0,'price':double.tryParse(p.text)??0};if(r==null){await d.insert('products',v);}else{await d.update('products',v,where:'id=?',whereArgs:[r['id']]);}n.clear();q.clear();p.clear();load();}
Future<void> remove(Object? id)async{await (await db).delete('products',where:'id=?',whereArgs:[id]);load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Inventory')),body:Column(children:[TextField(controller:n,decoration:const InputDecoration(labelText:'Product')),TextField(controller:q,decoration:const InputDecoration(labelText:'Quantity')),TextField(controller:p,decoration:const InputDecoration(labelText:'Price')),ElevatedButton(onPressed:()=>save(),child:const Text('Add')),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['name']}'),subtitle:Text('Qty ${r['quantity']} | ₹${r['price']}'),onTap:(){n.text='${r['name']}';q.text='${r['quantity']}';p.text='${r['price']}';},trailing:Wrap(children:[IconButton(icon:const Icon(Icons.save),onPressed:()=>save(r)),IconButton(icon:const Icon(Icons.delete),onPressed:()=>remove(r['id']))]))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
