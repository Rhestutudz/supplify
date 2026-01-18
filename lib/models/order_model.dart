import 'order_item_model.dart';

class Order {
  final int id;
  final int userId;
  final String status;
  final double total;
  final String createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      createdAt: json['created_at'] ?? '',
      items: json['items'] != null
          ? List<OrderItem>.from(
              json['items'].map((x) => OrderItem.fromJson(x)),
            )
          : [],
    );
  }
}
