import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/category_model.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/category/get.php'),
    );

    final json = jsonDecode(res.body);
    return (json['data'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }
}
