import 'dart:async';
import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===== LOGO =====
            Image.asset(
              'assets/images/logo.jpg',
              width: 120,
            ),

            const SizedBox(height: 20),

            // ===== APP NAME =====
            const Text(
              'Supplify App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),

            const SizedBox(height: 8),

            // ===== SUBTITLE =====
            const Text(
              'Aplikasi Distributor Modern',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // ===== NAMA ANGGOTA =====
            const Text(
              '152022088 - Alonza Nara Sandika',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              '152022129 - Sugiri Satrio Wicaksono',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              '152022164 - Rhestu Dzulkifli',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // ===== LOADING =====
            const CircularProgressIndicator(
              color: teal,
            ),
          ],
        ),
      ),
    );
  }
}
