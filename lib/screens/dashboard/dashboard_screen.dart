import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // ====== WARNA SUPPLIIFY ======
  static const Color primaryBlue = Color(0xFF0A2540);
  static const Color teal = Color(0xFF2EC4B6);
  static const Color softPurple = Color(0xFFE9E3FF);
  static const Color background = Color(0xFFF7F5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Distributor Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
          ),
        ],
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HERO / LOGO ----------
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ---------- TITLE ----------
            const Text(
              'Distributor Universal',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Platform manajemen distributor yang membantu Anda mengelola '
              'produk, pesanan, dan mitra bisnis secara terintegrasi, cepat, '
              'dan aman.',
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 32),

            // ---------- FEATURE CARDS ----------
            Row(
              children: [
                _featureCard(
                  icon: Icons.inventory_2,
                  title: 'Manajemen Produk',
                  desc: 'Tambah, edit, dan kelola stok produk secara real-time.',
                ),
                const SizedBox(width: 16),
                _featureCard(
                  icon: Icons.receipt_long,
                  title: 'Manajemen Pesanan',
                  desc: 'Pantau dan proses pesanan distributor dengan mudah.',
                ),
                const SizedBox(width: 16),
                _featureCard(
                  icon: Icons.people_alt,
                  title: 'Manajemen Distributor',
                  desc: 'Kelola mitra distributor dalam satu sistem.',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ---------- INFO BANNER ----------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [teal, Color(0xFF5F6FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_shipping, color: Colors.white, size: 36),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Kelola seluruh proses distribusi Anda dalam satu '
                      'platform yang modern dan terintegrasi.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= FEATURE CARD WIDGET =================
  static Widget _featureCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: softPurple,
              child: Icon(icon, color: primaryBlue, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
