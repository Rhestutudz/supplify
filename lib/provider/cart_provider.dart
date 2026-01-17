import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItem {
  final Product product;
  int qty;

  CartItem({required this.product, this.qty = 1});

  double get subtotal => qty * product.price;
}

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.qty++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  double get total {
    double t = 0;
    for (var i in _items.values) {
      t += i.subtotal;
    }
    return t;
  }

  void increase(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.qty++;
      notifyListeners();
    }
  }

  void decrease(int productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.qty > 1) {
        _items[productId]!.qty--;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
