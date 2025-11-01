// lib/features/product_details/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);

    // Function to handle the Add to Cart action
    void handleAddToCart() {
      cartNotifier.addToCart(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: const TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF131921),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Product Name and Rating
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(
                  ' ${product.rating} | 1,234 Ratings',
                  style: const TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // 2. Product Image
            Center(
              child: Image.network(
                product.imageUrl,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 15),

            // 3. Price Tag
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFFB12704), // Amazon's red price color
              ),
            ),
            const SizedBox(height: 20),

            // --- Action Buttons ---
            // 4. Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD814), // Amazon Yellow
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 5. Buy Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement Buy Now logic (adds to cart and navigates to checkout)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9900), // Amazon Orange
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 6. Product Description
            const Text(
              'About this item:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),

            // Add more details like specifications, size, color options here...
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}