import 'package:e_shop/model/product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    var existingItem = _cartItems.firstWhere(
            (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0));

    if (existingItem.quantity == 0) {
      _cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      existingItem.quantity++;
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    var existingItem = _cartItems.firstWhere(
            (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0));

    if (existingItem.quantity > 0) {
      existingItem.quantity = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
