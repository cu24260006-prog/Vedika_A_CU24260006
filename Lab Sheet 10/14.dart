import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 14: Notes app: logged-in user add view delete notes
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: NotesPage())); }
class NotesPage extends StatefulWidget { const NotesPage({super.key}); @override State<NotesPage> createState()=>_NotesPageState(); }
class _NotesPageState extends State<NotesPage>{final note=TextEditingController();User? get user=>FirebaseAuth.instance.currentUser;
Future<void> add()async{if(user==null)return;await FirebaseFirestore.instance.collection('notes').add({'text':note.text,'userId':user!.uid,'createdAt':FieldValue.serverTimestamp()});note.clear();}
@override Widget build(BuildContext c){if(user==null)return const Scaffold(body:Center(child:Text('Please log in first')));return Scaffold(appBar:AppBar(title:const Text('My Notes')),body:Column(children:[TextField(controller:note,decoration:const InputDecoration(labelText:'Note')),ElevatedButton(onPressed:add,child:const Text('Add Note')),Expanded(child:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('notes').where('userId',isEqualTo:user!.uid).snapshots(),builder:(context,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());return ListView(children:s.data!.docs.map((d){final x=d.data() as Map<String,dynamic>;return ListTile(title:Text(x['text']??''),trailing:IconButton(icon:const Icon(Icons.delete),onPressed:()=>d.reference.delete()));}).toList());}))]));}}
