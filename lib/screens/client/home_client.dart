import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import '../../widgets/product_horizontal.dart';
import '../../widgets/section_title.dart';
import '../../widgets/quick_menu.dart';
import '../../provider/cart_provider.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'product_by_category.dart';
import 'promo_screen.dart';
import 'daftar_screen.dart';
import 'pesanan_screen.dart';
import 'akun_screen.dart';

// ===== WARNA SUPPLIFY =====
const Color primaryBlue = Color(0xFF0A2540);
const Color teal = Color(0xFF2EC4B6);
const Color background = Color(0xFFF7F9FC);

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  int _currentIndex = 0;
  bool isLoading = true;

  // ===== DATA PER KATEGORI (WAJIB DIPISAH) =====
  List<Product> makanan = [];
  List<Product> minuman = [];
  List<Product> sembako = [];
  List<Product> ibuAnak = [];
  List<Product> rumahTangga = [];

  @override
  void initState() {
    super.initState();
    _loadAllCategoryProducts();
  }

  // ===== LOAD DATA DARI API PER KATEGORI =====
  Future<void> _loadAllCategoryProducts() async {
    try {
      makanan = await ProductService.getProductsByCategory(1);
      minuman = await ProductService.getProductsByCategory(2);
      sembako = await ProductService.getProductsByCategory(3);
      ibuAnak = await ProductService.getProductsByCategory(4);
      rumahTangga = await ProductService.getProductsByCategory(5);

      // DEBUG (boleh dihapus nanti)
      print('Makanan: ${makanan.length}');
      print('Minuman: ${minuman.length}');
      print('Sembako: ${sembako.length}');
      print('Ibu & Anak: ${ibuAnak.length}');
      print('Rumah Tangga: ${rumahTangga.length}');

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat produk')),
      );
    }
  }

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
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: primaryBlue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const Icon(Icons.notifications_none, color: primaryBlue),
          const SizedBox(width: 12),
        ],
      ),

      // ================= BODY =================
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ===== SEARCH =====
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari barang kebutuhan...',
                        prefixIcon:
                            const Icon(Icons.search, color: primaryBlue),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // ===== BANNER =====
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [teal, Color(0xFF4FACFE)],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PROMO JSM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Jumat • Sabtu • Minggu\nHarga spesial distributor',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== QUICK MENU (JANGAN DIHAPUS) =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickMenu(
                          icon: Icons.category,
                          label: 'Kategori',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CategoryScreen()),
                          ),
                        ),
                        QuickMenu(
                          icon: Icons.restaurant,
                          label: 'Makanan',
                          onTap: () => _goCategory(1, 'Makanan'),
                        ),
                        QuickMenu(
                          icon: Icons.local_drink,
                          label: 'Minuman',
                          onTap: () => _goCategory(2, 'Minuman'),
                        ),
                        QuickMenu(
                          icon: Icons.shopping_bag,
                          label: 'Sembako',
                          onTap: () => _goCategory(3, 'Sembako'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== SECTION PRODUK =====
                  _section('Makanan', makanan, 1),
                  _section('Minuman', minuman, 2),
                  _section('Sembako', sembako, 3),
                  _section('Ibu & Anak', ibuAnak, 4),
                  _section('Rumah Tangga', rumahTangga, 5),

                  const SizedBox(height: 40),
                ],
              ),
            ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: teal,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() => _currentIndex = i);

          if (i == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const PromoScreen()));
          } else if (i == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const DaftarScreen()));
          } else if (i == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const PesananScreen()));
          } else if (i == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AkunScreen()));
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

  // ===== HELPER =====
  Widget _section(String title, List<Product> products, int categoryId) {
    return Column(
      children: [
        SectionTitle(
          title: title,
          onSeeAll: () => _goCategory(categoryId, title),
        ),
        ProductHorizontal(products: products),
      ],
    );
  }

  void _goCategory(int id, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProductByCategoryScreen(categoryId: id, categoryName: name),
      ),
    );
  }
}
