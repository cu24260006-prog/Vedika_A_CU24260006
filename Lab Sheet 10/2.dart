import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 2: Register user with email and password
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: RegisterPage())); }
class RegisterPage extends StatefulWidget { const RegisterPage({super.key}); @override State<RegisterPage> createState()=>_RegisterPageState(); }
class _RegisterPageState extends State<RegisterPage> {
 final email=TextEditingController(), password=TextEditingController(); String message='';
 Future<void> register() async { try { await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email.text.trim(),password:password.text); setState(()=>message='Registration successful'); } on FirebaseAuthException catch(e){setState(()=>message=e.message??'Registration failed');} }
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Register')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),ElevatedButton(onPressed:register,child:const Text('Register')),Text(message)])));
}
