import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 1: Initialize Firebase and show Firebase Connected
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Use generated options if required by your setup.
  runApp(const MaterialApp(home: ConnectedPage()));
}
class ConnectedPage extends StatelessWidget {
  const ConnectedPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Firebase Setup')),
    body: const Center(child: Text('Firebase Connected', style: TextStyle(fontSize: 22))));
}
