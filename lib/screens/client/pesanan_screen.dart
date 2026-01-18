import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/order_provider.dart';
import '../../services/session_service.dart';

// import halaman lain
import 'home_client.dart';
import 'promo_screen.dart';
import 'daftar_screen.dart';
import 'akun_screen.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final userId = await SessionService.getUserId();
    if (userId != null) {
      context.read<OrderProvider>().fetchOrders(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0A2540),
        elevation: 0,
      ),

      // ================= BODY =================
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.error != null
              ? Center(
                  child: Text(
                    'Error: ${orderProvider.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : orderProvider.orders.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada pesanan',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.orders[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          'Order #${order.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Status: ${order.status}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          'Rp ${order.total}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2EC4B6),
                          ),
                        ),
                      ),
                    );
                  },
                ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF2EC4B6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == _currentIndex) return;

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeClient()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PromoScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DaftarScreen()),
            );
          } else if (index == 4) {
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
}
