import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';

class AdminService {
  // ===== GET PENDING CLIENT =====
  static Future<List<dynamic>> getPendingClients() async {
    final res = await http.get(
      Uri.parse('${Api.baseUrl}/admin/pending_clients.php'),
    );

    final json = jsonDecode(res.body);
    return json['data'];
  }

  // ===== APPROVE CLIENT =====
  static Future<Map<String, dynamic>> approveClient(int id) async {
    final res = await http.post(
      Uri.parse('${Api.baseUrl}/admin/approve_client.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    return jsonDecode(res.body);
  }

  // ===== REJECT CLIENT =====
  static Future<Map<String, dynamic>> rejectClient(int id) async {
    final res = await http.post(
      Uri.parse('${Api.baseUrl}/admin/reject_client.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    return jsonDecode(res.body);
  }
}
