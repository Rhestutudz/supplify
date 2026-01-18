import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Supplify',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== BRANDING CARD =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 160,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ===== MANFAAT UNTUK PENGGUNA =====
            _benefitCard(
              icon: Icons.trending_down,
              title: 'Harga Lebih Murah',
              desc:
                  'Produk dijual dengan harga distributor sehingga lebih hemat dibandingkan harga eceran.',
            ),
            _benefitCard(
              icon: Icons.shopping_cart,
              title: 'Belanja Mudah',
              desc:
                  'Proses belanja dilakukan langsung melalui aplikasi dengan tampilan yang sederhana dan mudah dipahami.',
            ),
            _benefitCard(
              icon: Icons.local_offer,
              title: 'Promo Menarik',
              desc:
                  'Pengguna dapat menikmati berbagai promo dan penawaran menarik secara berkala.',
            ),
            _benefitCard(
              icon: Icons.lock,
              title: 'Aman & Terpercaya',
              desc:
                  'Transaksi dilakukan secara aman dan data pengguna terjaga dengan baik.',
            ),

            const SizedBox(height: 24),

            // ===== CTA BANNER =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [teal, Color(0xFF4FACFE)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shopping_bag, color: Colors.white, size: 32),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Mulai belanja sekarang dan nikmati kemudahan '
                      'berbelanja dengan harga distributor.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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

  // ================= BENEFIT CARD =================
  Widget _benefitCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: teal.withOpacity(0.15),
            child: Icon(icon, color: teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.6,
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
