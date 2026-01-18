import 'order_item_model.dart';

class Order {
  final int id;
  final int userId;
  final String status;
  final double total; // ✅ gunakan total
  final String createdAt;
  final String customerName;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.customerName,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final items = json['items'] is List
        ? List<OrderItem>.from(
            json['items'].map((x) => OrderItem.fromJson(x)),
          )
        : <OrderItem>[];

    return Order(
      id: int.tryParse(json['id'].toString()) ?? 0,
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      status: json['status'] ?? 'pending',
      total: double.tryParse(json['total'].toString()) ?? 0.0, // ✅ FIX UTAMA
      createdAt: json['created_at'] ?? '',
      customerName: json['user_name'] ?? '-',
      items: items,
    );
  }
}
