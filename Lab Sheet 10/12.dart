import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 12: Filter students by selected course using where query
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: CoursePage())); }
class CoursePage extends StatefulWidget { const CoursePage({super.key}); @override State<CoursePage> createState()=>_CoursePageState(); }
class _CoursePageState extends State<CoursePage>{String course='BCA';final choices=['BCA','BBA','BSc'];@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Students by Course')),body:Column(children:[DropdownButton<String>(value:course,items:choices.map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>course=v!)),Expanded(child:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('students').where('course',isEqualTo:course).snapshots(),builder:(context,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());return ListView(children:s.data!.docs.map((d){final x=d.data() as Map<String,dynamic>;return ListTile(title:Text(x['name']??''),subtitle:Text(x['rollNumber']??''));}).toList());}))]));}
