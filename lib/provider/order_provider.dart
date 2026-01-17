import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  // ================= DATA =================
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  // ================= GETTER =================
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ================= CLIENT: PESANAN SAYA =================
  Future<void> fetchOrders(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await OrderService.getOrders(userId);
    } catch (e) {
      _orders = [];
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= ADMIN: SEMUA PESANAN =================
  Future<void> fetchAllOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await OrderService.getAllOrders();
    } catch (e) {
      _orders = [];
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= ADMIN: UPDATE STATUS =================
  Future<void> updateOrderStatus(int orderId, String status) async {
    try {
      await OrderService.updateOrderStatus(orderId, status);
      await fetchAllOrders(); // refresh data
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // ================= CLEAR (LOGOUT) =================
  void clear() {
    _orders = [];
    _error = null;
    notifyListeners();
  }
}
