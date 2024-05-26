import 'dart:convert';
import 'package:e_shop/model/product.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    try {
      final String response = await rootBundle.loadString('assets/products.json');
      final List<dynamic> data = json.decode(response);
      print("JSON data loaded: $data"); // Debug statement
      return Product.fromJsonList(data);
    } catch (e) {
      print("Error loading JSON data: $e");
      return [];
    }
  }
}
