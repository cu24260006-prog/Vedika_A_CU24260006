import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 4: Display logged-in email and Logout button
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: HomePage())); }
class HomePage extends StatelessWidget { const HomePage({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Home')),body:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[Text('Logged in: ${FirebaseAuth.instance.currentUser?.email ?? "No user"}'),ElevatedButton(onPressed:()=>FirebaseAuth.instance.signOut(),child:const Text('Logout'))]))); }
