import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 8: Add student record to Cloud Firestore
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: AddStudentPage())); }
class AddStudentPage extends StatefulWidget { const AddStudentPage({super.key}); @override State<AddStudentPage> createState()=>_AddStudentPageState(); }
class _AddStudentPageState extends State<AddStudentPage>{final name=TextEditingController(),roll=TextEditingController(),course=TextEditingController();
Future<void> save()async{await FirebaseFirestore.instance.collection('students').add({'name':name.text,'rollNumber':roll.text,'course':course.text});if(mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Student added')));}
@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Add Student')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:name,decoration:const InputDecoration(labelText:'Name')),TextField(controller:roll,decoration:const InputDecoration(labelText:'Roll Number')),TextField(controller:course,decoration:const InputDecoration(labelText:'Course')),ElevatedButton(onPressed:save,child:const Text('Save'))])));
}
