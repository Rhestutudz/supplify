import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _promoCard(
            title: 'PROMO JSM',
            desc: 'Diskon khusus Jumat - Minggu',
          ),
          _promoCard(
            title: 'Gratis Ongkir',
            desc: 'Minimal belanja Rp 200.000',
          ),
        ],
      ),
    );
  }

  Widget _promoCard({required String title, required String desc}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.green),
        title: Text(title),
        subtitle: Text(desc),
      ),
    );
  }
}
