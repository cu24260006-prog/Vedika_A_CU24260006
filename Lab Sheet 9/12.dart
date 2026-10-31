import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 12: Filter API data using search TextField
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  List<dynamic> all = []; String query = '';
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (r.statusCode == 200) setState(() => all = jsonDecode(r.body));
  }
  @override Widget build(BuildContext context) {
    final filtered = all.where((u) => u['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(appBar: AppBar(title: const Text('Search Users')),
      body: Column(children: [
        TextField(decoration: const InputDecoration(labelText: 'Search by name'), onChanged: (v) => setState(() => query = v)),
        Expanded(child: ListView(children: filtered.map((u) => ListTile(title: Text(u['name']), subtitle: Text(u['email']))).toList()))
      ]));
  }
}
void main() => runApp(const MaterialApp(home: SearchPage()));
