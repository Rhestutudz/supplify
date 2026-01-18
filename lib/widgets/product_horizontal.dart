import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class ProductHorizontal extends StatelessWidget {
  final List<Product> products;

  const ProductHorizontal({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Produk belum tersedia',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: 230,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];

          // DEBUG (boleh hapus nanti)
          debugPrint('HORIZONTAL IMAGE URL: ${product.imageUrl}');

          return Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= IMAGE =================
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: product.imageUrl != null &&
                            product.imageUrl!.isNotEmpty
                        ? Image.network(
                            product.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _imageFallback();
                            },
                          )
                        : _imageFallback(),
                  ),
                ),

                const SizedBox(height: 8),

                // ================= NAME =================
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                // ================= PRICE =================
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(
                    color: Color(0xFF2EC4B6),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                // ================= BUTTON =================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2EC4B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<CartProvider>().add(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} ditambahkan ke keranjang',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text('Tambah'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= FALLBACK IMAGE =================
  Widget _imageFallback() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.image,
          size: 32,
          color: Colors.grey,
        ),
      ),
    );
  }
}
