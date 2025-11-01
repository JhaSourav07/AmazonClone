// lib/features/cart/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart'; // We will create this next

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the list of products in the cart
    final cartItems = ref.watch(cartProvider);
    final totalAmount = ref.watch(cartProvider.notifier).totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: const Color(0xFF131921), // Amazon AppBar color
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your Amazon Cart is Empty.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
          : Column(
        children: <Widget>[
          // 1. Subtotal summary (sticky at the top)
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal (${cartItems.length} items):',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB12704), // Red for price
                  ),
                ),
              ],
            ),
          ),

          // 2. Proceed to Checkout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement navigation to CheckoutScreen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to Checkout! (Feature TBD)')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD814), // Amazon yellow button
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Proceed to Buy',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),

          // 3. List of Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                // Use the dedicated tile widget
                return CartItemTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}