import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 13: Order students by name using orderBy
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: SortedStudentsPage())); }
class SortedStudentsPage extends StatelessWidget { const SortedStudentsPage({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Students A to Z')),body:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('students').orderBy('name').snapshots(),builder:(context,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());return ListView(children:s.data!.docs.map((d){final x=d.data() as Map<String,dynamic>;return ListTile(title:Text(x['name']??''),subtitle:Text(x['course']??''));}).toList());}));}
