import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 11: User list and detail screen
class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});
  @override State<UserDetailsPage> createState() => _UserDetailsPageState();
}
class _UserDetailsPageState extends State<UserDetailsPage> {
  List<dynamic> users = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (r.statusCode == 200) setState(() => users = jsonDecode(r.body));
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Select a User')),
    body: ListView.builder(itemCount: users.length, itemBuilder: (context, i) {
      final u = users[i];
      return ListTile(title: Text(u['name']), subtitle: Text(u['email']),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
          Scaffold(appBar: AppBar(title: const Text('User Details')),
            body: Padding(padding: const EdgeInsets.all(16), child: Text(
              'Name: ${u['name']}\nEmail: ${u['email']}\nPhone: ${u['phone']}\nWebsite: ${u['website']}\nCompany: ${u['company']['name']}')))));
    }));
}
void main() => runApp(const MaterialApp(home: UserDetailsPage()));
