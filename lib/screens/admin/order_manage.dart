import 'package:flutter/material.dart';

class OrderManageScreen extends StatelessWidget {
  const OrderManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Order'),
      ),
      body: ListView(
        children: const [
          OrderCard(
            orderId: 'ORD001',
            customer: 'Client A',
            status: 'Pending',
          ),
          OrderCard(
            orderId: 'ORD002',
            customer: 'Client B',
            status: 'Paid',
          ),
          OrderCard(
            orderId: 'ORD003',
            customer: 'Client C',
            status: 'Process',
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String customer;
  final String status;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.customer,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text('Order $orderId'),
        subtitle: Text('Customer: $customer'),
        trailing: DropdownButton<String>(
          value: status,
          items: const [
            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
            DropdownMenuItem(value: 'Waiting Payment', child: Text('Waiting Payment')),
            DropdownMenuItem(value: 'Paid', child: Text('Paid')),
            DropdownMenuItem(value: 'Process', child: Text('Process')),
            DropdownMenuItem(value: 'Done', child: Text('Done')),
          ],
          onChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Status diubah ke $value')),
            );
          },
        ),
      ),
    );
  }
}
