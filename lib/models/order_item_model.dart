class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final int qty;
  final double price;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.qty,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      qty: json['qty'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}
