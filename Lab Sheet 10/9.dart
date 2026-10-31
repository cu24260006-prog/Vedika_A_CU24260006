import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 9: Display Firestore students in real time using StreamBuilder
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: StudentsPage())); }
class StudentsPage extends StatelessWidget { const StudentsPage({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Student Records')),body:StreamBuilder<QuerySnapshot>(
 stream:FirebaseFirestore.instance.collection('students').snapshots(),builder:(context,s){if(s.hasError)return const Center(child:Text('Error loading records'));if(!s.hasData)return const Center(child:CircularProgressIndicator());final docs=s.data!.docs;return ListView.builder(itemCount:docs.length,itemBuilder:(context,i){final d=docs[i].data() as Map<String,dynamic>;return ListTile(title:Text(d['name']??''),subtitle:Text('${d['rollNumber']??''} - ${d['course']??''}'));});}));}
