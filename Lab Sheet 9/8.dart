import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 8: Fetch users and display name and email with ListTile and CircleAvatar
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});
  @override State<UsersPage> createState() => _UsersPageState();
}
class _UsersPageState extends State<UsersPage> {
  List<dynamic> users = [];
  @override void initState() { super.initState(); loadUsers(); }
  Future<void> loadUsers() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (r.statusCode == 200) setState(() => users = jsonDecode(r.body));
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Users')),
    body: ListView.builder(itemCount: users.length, itemBuilder: (context, i) {
      final u = users[i];
      return ListTile(leading: CircleAvatar(child: Text(u['name'][0])),
        title: Text(u['name']), subtitle: Text(u['email']));
    }));
}
void main() => runApp(const MaterialApp(home: UsersPage()));
