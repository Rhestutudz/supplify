import 'dart:convert';
import 'package:http/http.dart' as http;

// ⬇️ FIX PATH (WAJIB)
import '../../constants/api.dart';
import '../../models/order_model.dart';
import '../../models/order_item_model.dart';
import '../../provider/cart_provider.dart';
import 'session_service.dart';

class OrderService {

  // ================= CHECKOUT =================
  static Future<void> checkout(CartProvider cart) async {
    final userId = await SessionService.getUserId();
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final res = await http.post(
      Uri.parse('${Api.baseUrl}/orders/create.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'items': cart.items.values.map((e) => {
          'product_id': e.product.id,
          'qty': e.qty,
          'price': e.product.price,
        }).toList(),
      }),
    );

    final json = jsonDecode(res.body);
    if (res.statusCode != 200 || json['status'] != true) {
      throw Exception(json['message'] ?? 'Checkout gagal');
    }
  }

  // ================= ORDER USER =================
  static Future<List<Order>> getOrders(int userId) async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/orders/user.php?user_id=$userId'),
    );

    final json = jsonDecode(res.body);
    if (json['status'] == true) {
      return (json['data'] as List)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      throw Exception(json['message'] ?? 'Gagal ambil order');
    }
  }

  // ================= ORDER ADMIN =================
  static Future<List<Order>> getAllOrders() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/orders/get_all.php'),
    );

    final json = jsonDecode(res.body);
    if (json['status'] == true && json['data'] != null) {
      return (json['data'] as List)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      throw Exception(json['message'] ?? 'Data order kosong');
    }
  }

  // ================= UPDATE STATUS =================
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
    if (res.statusCode != 200 || json['status'] != true) {
      throw Exception(json['message'] ?? 'Gagal update status');
    }
  }

  // ================= ORDER DETAIL =================
  static Future<List<OrderItem>> getOrderItems(int orderId) async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/orders/detail.php?order_id=$orderId'),
    );

    final json = jsonDecode(res.body);
    if (json['status'] == true) {
      return (json['data'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList();
    } else {
      throw Exception(json['message'] ?? 'Gagal ambil detail order');
    }
  }

  // ================= DASHBOARD ADMIN (FIX ERROR) =================
  static Future<Map<String, dynamic>> getDashboard() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/orders/dashboard.php'),
    );

    final json = jsonDecode(res.body);
    if (json['status'] == true) {
      return json['data'];
    } else {
      throw Exception(json['message'] ?? 'Gagal ambil dashboard');
    }
  }
}
