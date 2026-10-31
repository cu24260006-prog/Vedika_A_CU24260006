import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 9: Convert API data into model objects using fromJson
class Post {
  final int id; final String title; final String body;
  Post({required this.id, required this.title, required this.body});
  factory Post.fromJson(Map<String, dynamic> j) =>
    Post(id: j['id'], title: j['title'], body: j['body']);
}
class ModelPage extends StatefulWidget {
  const ModelPage({super.key});
  @override State<ModelPage> createState() => _ModelPageState();
}
class _ModelPageState extends State<ModelPage> {
  List<Post> posts = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode == 200) setState(() => posts = (jsonDecode(r.body) as List).map((e) => Post.fromJson(e)).toList());
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Posts with Model')),
    body: ListView.builder(itemCount: posts.length, itemBuilder: (context, i) =>
      ListTile(title: Text(posts[i].title), subtitle: Text(posts[i].body))));
}
void main() => runApp(const MaterialApp(home: ModelPage()));
