import 'package:flutter/material.dart';
import 'home_client.dart';
import 'promo_screen.dart';
import 'daftar_screen.dart';
import 'pesanan_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  int _currentIndex = 4; // posisi Akun

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Akun Saya',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ===== PROFILE CARD =====
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: teal,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(
                  'Client Supplify',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'client@email.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ===== MENU CARD =====
          _menuCard(
            icon: Icons.shopping_bag_outlined,
            title: 'Pesanan Saya',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PesananScreen()),
              );
            },
          ),

          _menuCard(
            icon: Icons.list_alt,
            title: 'Daftar Produk',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DaftarScreen()),
              );
            },
          ),

          _menuCard(
            icon: Icons.local_offer_outlined,
            title: 'Promo Supplify',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PromoScreen()),
              );
            },
          ),

          _menuCard(
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
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
          } else if (i == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DaftarScreen()),
            );
          } else if (i == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PesananScreen()),
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

  // ================= MENU TILE =================
  Widget _menuCard({
    required IconData icon,
    required String title,
    Color color = primaryBlue,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ================= LOGOUT DIALOG =================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Logout'),
        content: const Text('Apakah kamu yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
