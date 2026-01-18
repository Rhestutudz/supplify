import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/order_model.dart';
import '../provider/cart_provider.dart';
import 'session_service.dart';

class OrderService {
  static Future<void> checkout(CartProvider cart) async {
    final userId = await SessionService.getUserId();
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final url = '${Api.baseUrl}/orders/create.php';
    print('Checkout URL: $url');
    
    final body = jsonEncode({
      'user_id': userId,
      'items': cart.items.values.map((e) => {
        'product_id': e.product.id,
        'qty': e.qty,
        'price': e.product.price,
      }).toList()
    });
    
    print('Checkout Body: $body');
    
    final res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response Status: ${res.statusCode}');
    print('Response Body: ${res.body}');

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final json = jsonDecode(res.body);
    if (!json['status']) {
      throw Exception(json['message'] ?? 'Unknown error');
    }
  }

  static Future<List<Order>> getOrders(int userId) async {
    final url = '${Api.baseUrl}/orders/user.php?user_id=$userId';
    final res = await http.get(
      Uri.parse(url),
    );

    final json = jsonDecode(res.body);
    if (json['status']) {
      final orders = (json['data'] as List).map((e) => Order.fromJson(e)).toList();
      return orders;
    } else {
      throw Exception(json['message']);
    }
  }

  static Future<List<Order>> getAllOrders() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/orders/all.php'),
    );

    final json = jsonDecode(res.body);
    if (json['status']) {
      return (json['data'] as List).map((e) => Order.fromJson(e)).toList();
    } else {
      throw Exception(json['message']);
    }
  }

  static Future<void> updateOrderStatus(int orderId, String status) async {
    final res = await http.put(
      Uri.parse('${Api.baseUrl}/orders/update_status.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'order_id': orderId,
        'status': status,
      }),
    );

    final json = jsonDecode(res.body);
    if (!json['status']) {
      throw Exception(json['message']);
    }
  }
}
