import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ===== PROVIDERS =====
import 'provider/cart_provider.dart';
import 'provider/order_provider.dart';

// ===== SCREENS =====
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';

// CLIENT
import 'screens/client/home_client.dart';
import 'screens/client/cart_screen.dart';
import 'screens/client/pesanan_screen.dart';
import 'screens/client/akun_screen.dart';

// ADMIN
import 'screens/admin/home_admin.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supplify',

      // ===== THEME SUPPLIFY =====
      theme: ThemeData(
        primaryColor: const Color(0xFF0A2540),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0A2540),
          elevation: 0,
        ),
        useMaterial3: false,
      ),

      // ===== INITIAL =====
      initialRoute: '/',

      // ===== ROUTES (WAJIB LENGKAP) =====
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),

        // ===== CLIENT =====
        '/home_client': (context) => const HomeClient(),
        '/cart': (context) => const CartScreen(),
        '/pesanan': (context) => const PesananScreen(),
        '/akun': (context) => const AkunScreen(),

        // ===== ADMIN =====
        '/home_admin': (context) => const HomeAdmin(),
      },

      // ===== FALLBACK (ANTI CRASH) =====
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      },
    );
  }
}
