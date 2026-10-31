import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 13: Reload API data using RefreshIndicator
class RefreshPage extends StatefulWidget {
  const RefreshPage({super.key});
  @override State<RefreshPage> createState() => _RefreshPageState();
}
class _RefreshPageState extends State<RefreshPage> {
  List<dynamic> posts = [];
  @override void initState() { super.initState(); refresh(); }
  Future<void> refresh() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode == 200) setState(() => posts = jsonDecode(r.body));
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pull to Refresh')),
    body: RefreshIndicator(onRefresh: refresh, child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(), itemCount: posts.length,
      itemBuilder: (context, i) => ListTile(title: Text(posts[i]['title'])))));
}
void main() => runApp(const MaterialApp(home: RefreshPage()));
