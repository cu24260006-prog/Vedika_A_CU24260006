import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 6: Reset password using sendPasswordResetEmail
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: ResetPage())); }
class ResetPage extends StatefulWidget { const ResetPage({super.key}); @override State<ResetPage> createState()=>_ResetPageState(); }
class _ResetPageState extends State<ResetPage> {
 final email=TextEditingController();
 Future<void> reset() async { try { await FirebaseAuth.instance.sendPasswordResetEmail(email:email.text.trim()); message('Password reset email sent'); } on FirebaseAuthException catch(e){message(e.message??'Unable to send email');} }
 void message(String m)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(m)));
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Reset Password')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),ElevatedButton(onPressed:reset,child:const Text('Send Reset Email'))])));
}
