import 'package:e_shop/controller/carteProvider.dart';
import 'package:e_shop/controller/productProvider.dart';
import 'package:e_shop/view/user_auth/cartPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
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
              onChanged: (query) {
                productProvider.updateSearchQuery(query);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Price Range'),
                RangeSlider(
                  values: productProvider.priceRange,
                  min: 0,
                  max: 1000,
                  divisions: 100,
                  labels: RangeLabels(
                    productProvider.priceRange.start.round().toString(),
                    productProvider.priceRange.end.round().toString(),
                  ),
                  onChanged: (range) {
                    productProvider.updatePriceRange(range);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(product.images.isNotEmpty
                            ? product.images.first
                            : 'https://via.placeholder.com/150'),
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        if (product.price < 50)
                          Text('Promotion: ${product.discountPercentage}% off',
                              style: const TextStyle(color: Colors.red)),
                        if (product.price < 10)
                          const Text('Vente Flash', style: TextStyle(color: Colors.red)),
                        if (DateTime.now()
                            .difference(product.creationDate)
                            .inDays <=
                            3)
                          const Text('Nouveau', style: TextStyle(color: Colors.blue)),
                        Text(product.description),
                        ElevatedButton(
                          onPressed: () {
                            cartProvider.addToCart(product);
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (productProvider.isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
