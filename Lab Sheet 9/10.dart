import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 10: Handle API errors with Retry button
class RetryPage extends StatefulWidget {
  const RetryPage({super.key});
  @override State<RetryPage> createState() => _RetryPageState();
}
class _RetryPageState extends State<RetryPage> {
  String message = 'Loading...'; bool loading = true;
  @override void initState() { super.initState(); fetch(); }
  Future<void> fetch() async {
    setState(() { loading = true; message = ''; });
    try {
      final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')).timeout(const Duration(seconds: 10));
      if (r.statusCode == 200) message = jsonDecode(r.body)['title'];
      else message = 'Server error: ${r.statusCode}';
    } catch (_) { message = 'No internet connection or request failed'; }
    setState(() => loading = false);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('API Error Handling')),
    body: Center(child: loading ? const CircularProgressIndicator() :
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(message), const SizedBox(height: 12),
        ElevatedButton(onPressed: fetch, child: const Text('Retry'))
      ])));
}
void main() => runApp(const MaterialApp(home: RetryPage()));
