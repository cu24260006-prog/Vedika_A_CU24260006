import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 15: Product Store with GridView, detail, loading and error handling
class ProductStorePage extends StatefulWidget {
  const ProductStorePage({super.key});
  @override State<ProductStorePage> createState() => _ProductStorePageState();
}
class _ProductStorePageState extends State<ProductStorePage> {
  List<dynamic> products = []; bool loading = true; String error = '';
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    try {
      final r = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (r.statusCode != 200) throw Exception('Server error ${r.statusCode}');
      products = jsonDecode(r.body);
    } catch (e) { error = e.toString(); }
    setState(() => loading = false);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Product Store')),
    body: loading ? const Center(child: CircularProgressIndicator()) :
      error.isNotEmpty ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(error), ElevatedButton(onPressed: () { setState(() { loading = true; error = ''; }); load(); }, child: const Text('Retry'))
      ])) : GridView.builder(padding: const EdgeInsets.all(8), itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .7),
        itemBuilder: (context, i) {
          final p = products[i];
          return Card(child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
            Scaffold(appBar: AppBar(title: const Text('Product Details')),
              body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
                Image.network(p['image'], height: 180, errorBuilder: (_, __, ___) => const Icon(Icons.image)),
                Text(p['title'], style: const TextStyle(fontSize: 18)),
                Text('Price: \$${p['price']}'), Text(p['description'])
              ]))))),
            child: Padding(padding: const EdgeInsets.all(8), child: Column(children: [
              Expanded(child: Image.network(p['image'], errorBuilder: (_, __, ___) => const Icon(Icons.image))),
              Text(p['title'], maxLines: 2, overflow: TextOverflow.ellipsis),
              Text('\$${p['price']}')
            ]))));
        }));
}
void main() => runApp(const MaterialApp(home: ProductStorePage()));
