import 'package:flutter/material.dart';

import 'product_by_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': 1, 'name': 'Makanan'},
      {'id': 2, 'name': 'Minuman'},
      {'id': 3, 'name': 'Sembako'},
      {'id': 4, 'name': 'Ibu & Anak'},
      {'id': 5, 'name': 'Rumah Tangga'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Semua Kategori')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final c = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductByCategoryScreen(
                    categoryName: c['name'] as String,
                    categoryId: c['id'] as int,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  c['name'] as String,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
