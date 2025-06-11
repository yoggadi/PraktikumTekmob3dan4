import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product['image']!, height: 200),
            const SizedBox(height: 16),
            Text(
              product['name']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              product['price']!,
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 24),
            const Text(
              'Deskripsi Produk: Ini adalah produk berkualitas tinggi yang sangat direkomendasikan untuk kebutuhan Anda sehari-hari.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
