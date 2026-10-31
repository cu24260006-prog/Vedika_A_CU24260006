import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 3: Login using signInWithEmailAndPassword
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: LoginPage())); }
class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
 final email=TextEditingController(), password=TextEditingController(); String message='';
 Future<void> login() async { try { await FirebaseAuth.instance.signInWithEmailAndPassword(email:email.text.trim(),password:password.text); setState(()=>message='Login successful'); } on FirebaseAuthException catch(e){setState(()=>message=e.message??'Login failed');} }
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Login')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),ElevatedButton(onPressed:login,child:const Text('Login')),Text(message)])));
}
