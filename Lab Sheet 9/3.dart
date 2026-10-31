import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 3: Fetch public REST API using http.get and display response
class ApiPage extends StatefulWidget {
  const ApiPage({super.key});
  @override State<ApiPage> createState() => _ApiPageState();
}
class _ApiPageState extends State<ApiPage> {
  String result = 'Tap the button to fetch data';
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    setState(() => result = response.statusCode == 200 ? response.body : 'Request failed');
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('REST API')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      ElevatedButton(onPressed: fetchData, child: const Text('Fetch Data')),
      Expanded(child: SingleChildScrollView(child: Text(result)))
    ])));
}
void main() => runApp(const MaterialApp(home: ApiPage()));
