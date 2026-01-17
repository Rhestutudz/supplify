import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Daftar produk akan tampil di sini\n(Data dari API)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
