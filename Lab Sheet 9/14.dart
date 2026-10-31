import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 14: Send data using http.post from a form
class PostFormPage extends StatefulWidget {
  const PostFormPage({super.key});
  @override State<PostFormPage> createState() => _PostFormPageState();
}
class _PostFormPageState extends State<PostFormPage> {
  final title = TextEditingController(), body = TextEditingController();
  String message = '';
  Future<void> send() async {
    final r = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': title.text, 'body': body.text, 'userId': 1}));
    setState(() => message = r.statusCode == 201 ? 'Post created successfully: ${r.body}' : 'Failed: ${r.statusCode}');
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create Post')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
      TextField(controller: body, decoration: const InputDecoration(labelText: 'Body')),
      ElevatedButton(onPressed: send, child: const Text('Submit')),
      Text(message)
    ])));
}
void main() => runApp(const MaterialApp(home: PostFormPage()));
