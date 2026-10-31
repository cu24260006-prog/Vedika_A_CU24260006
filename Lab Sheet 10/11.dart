import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 11: Delete student record from Firestore
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: DeleteStudentPage())); }
class DeleteStudentPage extends StatelessWidget { const DeleteStudentPage({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Delete Student')),body:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('students').snapshots(),builder:(context,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());return ListView(children:s.data!.docs.map((doc){final d=doc.data() as Map<String,dynamic>;return ListTile(title:Text(d['name']??''),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>doc.reference.delete()));}).toList());}));}
