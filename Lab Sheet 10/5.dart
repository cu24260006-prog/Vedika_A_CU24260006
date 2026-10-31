import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 5: Show authentication errors using SnackBar
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: AuthErrorPage())); }
class AuthErrorPage extends StatefulWidget { const AuthErrorPage({super.key}); @override State<AuthErrorPage> createState()=>_AuthErrorPageState(); }
class _AuthErrorPageState extends State<AuthErrorPage> {
 final email=TextEditingController(),password=TextEditingController();
 Future<void> register() async { try { await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email.text.trim(),password:password.text); show('Account created'); } on FirebaseAuthException catch(e){show(e.message??'Authentication error');} }
 void show(String m)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(m)));
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Authentication Errors')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),ElevatedButton(onPressed:register,child:const Text('Register'))])));
}
