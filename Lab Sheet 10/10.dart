import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 10: Update student record in Firestore
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: UpdateStudentPage())); }
class UpdateStudentPage extends StatelessWidget { const UpdateStudentPage({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Update Student')),body:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('students').snapshots(),builder:(context,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());return ListView(children:s.data!.docs.map((doc){final d=doc.data() as Map<String,dynamic>;return ListTile(title:Text(d['name']??''),trailing:IconButton(icon:const Icon(Icons.edit),onPressed:()async{final ctl=TextEditingController(text:d['name']??'');await showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Update Name'),content:TextField(controller:ctl),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),TextButton(onPressed:()async{await doc.reference.update({'name':ctl.text});if(context.mounted)Navigator.pop(context);},child:const Text('Save'))]));}));}).toList());}));}
