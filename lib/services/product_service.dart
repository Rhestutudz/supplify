import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/product_model.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/product/get.php'),
    );

    final json = jsonDecode(res.body);
    return (json['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  static Future<List<Product>> getProductsByCategory(int categoryId) async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/product/get.php?category_id=$categoryId'),
    );

    final json = jsonDecode(res.body);
    return (json['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }
  static Future<Map<String, dynamic>> createProduct({
  required String name,
  required String description,
  required String price,
  required String stock,
  required int categoryId,
}) async {
  final res = await http.post(
    Uri.parse('${Api.baseUrl}/product/create.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category_id': categoryId,
    }),
  );

  return jsonDecode(res.body);
}
// ===== UPDATE =====
static Future<Map<String, dynamic>> updateProduct({
  required int id,
  required String name,
  required String description,
  required String price,
  required String stock,
  required int categoryId,
}) async {
  final res = await http.post(
    Uri.parse('${Api.baseUrl}/product/update.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category_id': categoryId,
    }),
  );
  return jsonDecode(res.body);
}

// ===== DELETE =====
static Future<Map<String, dynamic>> deleteProduct(int id) async {
  final res = await http.post(
    Uri.parse('${Api.baseUrl}/product/delete.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id': id}),
  );
  return jsonDecode(res.body);
}

}

