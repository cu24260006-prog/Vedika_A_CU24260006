import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 7: Fetch posts and display titles using ListView.builder
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override State<PostsPage> createState() => _PostsPageState();
}
class _PostsPageState extends State<PostsPage> {
  List<dynamic> posts = []; bool loading = true;
  @override void initState() { super.initState(); loadPosts(); }
  Future<void> loadPosts() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode == 200) posts = jsonDecode(r.body);
    setState(() => loading = false);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post Titles')),
    body: loading ? const Center(child: CircularProgressIndicator()) :
      ListView.builder(itemCount: posts.length, itemBuilder: (context, i) =>
        ListTile(leading: CircleAvatar(child: Text('${i+1}')), title: Text(posts[i]['title']))));
}
void main() => runApp(const MaterialApp(home: PostsPage()));
