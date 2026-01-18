import 'package:flutter/material.dart';
import 'home_client.dart';
import 'daftar_screen.dart';
import 'pesanan_screen.dart';
import 'akun_screen.dart';

// ===== WARNA SUPPLIFY (SAMA DENGAN HOME) =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  int _currentIndex = 1; // posisi Promo

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
          'Promo Supplify',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: primaryBlue),
          SizedBox(width: 12),
        ],
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _PromoBanner(
            title: 'JURAGAN TANGO 2',
            date: '01 - 31 Januari 2026',
            image: 'assets/promos/promotango.png',
          ),
          SizedBox(height: 16),
          _PromoBanner(
            title: 'JSM JURAGAN TISSUE 2',
            date: '16 - 18 Januari 2026',
            image: 'assets/promos/promotisu.png',
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
}

// ================= PROMO BANNER CARD =================
class _PromoBanner extends StatelessWidget {
  final String title;
  final String date;
  final String image;

  const _PromoBanner({
    required this.title,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 4),

                // DATE
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                // BUTTON
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
