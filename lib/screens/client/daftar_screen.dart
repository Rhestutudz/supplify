import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Produk')),
      body: FutureBuilder<List<Product>>(
        future: ProductService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text('Produk belum tersedia'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) {
              final p = products[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(p.name),
                  subtitle: Text(
                    'Rp ${p.price} • Stok ${p.stock}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
