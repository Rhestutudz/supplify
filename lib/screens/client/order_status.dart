import 'package:flutter/material.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pesanan'),
      ),
      body: const Center(
        child: Text(
          'Status pesanan:\n\nPending → Waiting Payment → Paid → Process → Done',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
