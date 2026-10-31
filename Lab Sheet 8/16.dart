import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb(String name, String sql) async {
  final path = join(await getDatabasesPath(), name);
  return openDatabase(path, version: 1,
    onCreate: (db, version) async => db.execute(sql));
}

// Practical 16: Shopping cart with total
const sql='CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT,item TEXT,price REAL,quantity INTEGER)';
class Page extends StatefulWidget{const Page({super.key});@override State<Page> createState()=>_S();}
class _S extends State<Page>{Future<Database> get db=>openDb('cart.db',sql);final i=TextEditingController(),p=TextEditingController(),q=TextEditingController();List<Map<String,Object?>> rows=[];double total=0;
Future<void> load()async{final d=await db;final r=await d.query('cart');final s=await d.rawQuery('SELECT SUM(price*quantity) AS total FROM cart');setState((){rows=r;total=(s.first['total'] as num?)?.toDouble()??0;});}
Future<void> add()async{await (await db).insert('cart',{'item':i.text,'price':double.tryParse(p.text)??0,'quantity':int.tryParse(q.text)??1});i.clear();p.clear();q.clear();load();}
@override void initState(){super.initState();load();}
@override Widget build(BuildContext x)=>Scaffold(appBar:AppBar(title:const Text('Shopping Cart')),body:Column(children:[TextField(controller:i,decoration:const InputDecoration(labelText:'Item')),TextField(controller:p,decoration:const InputDecoration(labelText:'Price')),TextField(controller:q,decoration:const InputDecoration(labelText:'Quantity')),ElevatedButton(onPressed:add,child:const Text('Add to Cart')),Text('Total: ₹${total.toStringAsFixed(2)}'),Expanded(child:ListView(children:rows.map((r)=>ListTile(title:Text('${r['item']}'),subtitle:Text('${r['quantity']} x ₹${r['price']}'))).toList()))]));}
void main()=>runApp(const MaterialApp(home:Page()));
