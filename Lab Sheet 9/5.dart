import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 5: Show CircularProgressIndicator while fetching API data
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override State<LoadingPage> createState() => _LoadingPageState();
}
class _LoadingPageState extends State<LoadingPage> {
  bool loading = false; String message = '';
  Future<void> fetch() async {
    setState(() { loading = true; message = ''; });
    try {
      final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (r.statusCode == 200) message = jsonDecode(r.body)['title'];
      else message = 'Failed to fetch data';
    } catch (_) { message = 'Network error'; }
    setState(() => loading = false);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Loading Indicator')),
    body: Center(child: loading ? const CircularProgressIndicator() :
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(message), ElevatedButton(onPressed: fetch, child: const Text('Load Data'))
      ])));
}
void main() => runApp(const MaterialApp(home: LoadingPage()));
