import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/cart_provider.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    // DEBUG (boleh dihapus nanti)
    debugPrint('PRODUCT IMAGE URL: ${product.imageUrl}');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= IMAGE =================
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: product.imageUrl != null && product.imageUrl!.isNotEmpty
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

          // ================= DETAILS =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // PRICE
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
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
                    icon: const Icon(Icons.add_shopping_cart, size: 16),
                    label: const Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= FALLBACK IMAGE =================
  Widget _imageFallback() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.image,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }
}
