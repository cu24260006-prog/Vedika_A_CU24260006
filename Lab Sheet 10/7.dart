import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Practical 7: Show Login or Home based on authStateChanges
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const MaterialApp(home: AuthGate())); }
class AuthGate extends StatelessWidget { const AuthGate({super.key}); @override Widget build(BuildContext c)=>StreamBuilder<User?>(
 stream:FirebaseAuth.instance.authStateChanges(),builder:(context,s){if(s.connectionState==ConnectionState.waiting)return const Scaffold(body:Center(child:CircularProgressIndicator()));return s.data==null?const LoginScreen():const HomeScreen();}); }
class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen>{final e=TextEditingController(),p=TextEditingController();String error='';Future<void> login()async{try{await FirebaseAuth.instance.signInWithEmailAndPassword(email:e.text.trim(),password:p.text);}catch(x){setState(()=>error=x.toString());}} @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Login')),body:Column(children:[TextField(controller:e),TextField(controller:p,obscureText:true),ElevatedButton(onPressed:login,child:const Text('Login')),Text(error)]));}
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Home')),body:Center(child:ElevatedButton(onPressed:()=>FirebaseAuth.instance.signOut(),child:const Text('Logout')))); }
