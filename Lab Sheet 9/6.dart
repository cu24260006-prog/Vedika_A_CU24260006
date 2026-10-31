import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 6: Display API data using FutureBuilder
class FuturePage extends StatelessWidget {
  const FuturePage({super.key});
  Future<List<dynamic>> getPosts() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode != 200) throw Exception('Failed to load posts');
    return jsonDecode(r.body);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FutureBuilder Example')),
    body: FutureBuilder<List<dynamic>>(future: getPosts(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (snapshot.hasError) return Center(child: Text('${snapshot.error}'));
      return ListView(children: snapshot.data!.take(15).map((p) => ListTile(title: Text(p['title']))).toList());
    }));
}
void main() => runApp(const MaterialApp(home: FuturePage()));
