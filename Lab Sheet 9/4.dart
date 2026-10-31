import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 4: Fetch single post and display title and body in Card
class PostPage extends StatelessWidget {
  const PostPage({super.key});
  Future<Map<String, dynamic>> fetchPost() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (r.statusCode != 200) throw Exception('Unable to load post');
    return jsonDecode(r.body);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Single Post')),
    body: FutureBuilder<Map<String, dynamic>>(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        final post = snapshot.data!;
        return Card(margin: const EdgeInsets.all(16), child: Padding(
          padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(post['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10), Text(post['body'])
          ])));
      }));
}
void main() => runApp(const MaterialApp(home: PostPage()));
