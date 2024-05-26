import 'package:e_shop/model/product.dart';
import 'package:e_shop/service/productRepository.dart';
import 'package:flutter/material.dart';


class ProductProvider with ChangeNotifier {
  final ProductRepository repository = ProductRepository();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;
  String _searchQuery = '';
  RangeValues _priceRange = RangeValues(0, 200);

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  RangeValues get priceRange => _priceRange;

  Future<void> loadProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    _allProducts = await repository.fetchProducts();
    _filteredProducts = _allProducts;
    filterProducts();

    _isLoading = false;
    notifyListeners();
  }

  void filterProducts() {
    _filteredProducts = _allProducts.where((product) {
      final matchesQuery = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPrice = product.price >= _priceRange.start && product.price <= _priceRange.end;
      return matchesQuery && matchesPrice;
    }).toList();
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    filterProducts();
  }

  void updatePriceRange(RangeValues range) {
    _priceRange = range;
    filterProducts();
  }
}