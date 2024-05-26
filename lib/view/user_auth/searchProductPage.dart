import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/productProvider.dart';
import '../../model/product.dart';


class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  String _searchQuery = '';
  RangeValues _priceRange = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    List<Product> filteredProducts = productProvider.products
        .where((product) =>
    product.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
        product.price >= _priceRange.start &&
        product.price <= _priceRange.end)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000,
              divisions: 100,
              labels: RangeLabels(
                _priceRange.start.round().toString(),
                _priceRange.end.round().toString(),
              ),
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      if (product.price < 50)
                        Text('Promotion: ${product.discountPercentage}% off'),
                      if (product.price < 10) const Text('Vente Flash'),
                      if (DateTime.now().difference(product.creationDate).inDays <= 3)
                        const Text('Nouveau'),
                    ],
                  ),
                  leading: Image.network(product.images.first),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
