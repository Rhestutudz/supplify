import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import 'home_client.dart';
import 'promo_screen.dart';
import 'pesanan_screen.dart';
import 'akun_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  int _currentIndex = 2; // posisi "Daftar"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Produk',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= BODY =================
      body: FutureBuilder<List<Product>>(
        future: ProductService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Produk belum tersedia',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final products = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // ============ IMAGE ============
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(16),
                      ),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: product.imageUrl != null &&
                                product.imageUrl!.isNotEmpty
                            ? Image.network(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _imageFallback(),
                              )
                            : _imageFallback(),
                      ),
                    ),

                    // ============ INFO ============
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Rp ${product.price}',
                              style: const TextStyle(
                                color: teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Stok ${product.stock}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: teal,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          if (i == _currentIndex) return;

          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeClient()),
            );
          } else if (i == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PromoScreen()),
            );
          } else if (i == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PesananScreen()),
            );
          } else if (i == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AkunScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Promo'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Daftar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Pesanan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
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
