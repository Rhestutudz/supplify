import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../provider/order_provider.dart';
import '../../services/order_service.dart';
import '../../services/session_service.dart';
import 'pesanan_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

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
          'Keranjang',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= BODY =================
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Keranjang masih kosong',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                // ===== LIST ITEM KERANJANG =====
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: cart.items.values.map((item) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // INFO PRODUK
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Rp ${item.product.price} x ${item.qty}',
                                      style: const TextStyle(
                                        color: teal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // AKSI JUMLAH
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () =>
                                        cart.decrease(item.product.id),
                                  ),
                                  Text(
                                    item.qty.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cart.increase(item.product.id),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        cart.remove(item.product.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // ================= FOOTER CHECKOUT =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Rp ${cart.total}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: teal,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ===== TOMBOL CHECKOUT =====
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: teal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            // 1️⃣ Checkout ke backend
                            await OrderService.checkout(cart);

                            // 2️⃣ Ambil user ID dari session
                            final userId =
                                await SessionService.getUserId();
                            if (userId == null) {
                              throw Exception('User belum login');
                            }

                            // 3️⃣ Fetch ulang pesanan (KUNCI MASALAH)
                            await context
                                .read<OrderProvider>()
                                .fetchOrders(userId);

                            // 4️⃣ Kosongkan keranjang
                            cart.clear();

                            // 5️⃣ Notifikasi sukses
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Checkout berhasil 🎉'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // 6️⃣ Pindah ke Pesanan Saya
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PesananScreen(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Checkout gagal: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
}
