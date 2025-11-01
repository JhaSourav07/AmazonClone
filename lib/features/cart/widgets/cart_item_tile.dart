// lib/features/cart/widgets/cart_item_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';

class CartItemTile extends ConsumerWidget {
  final Product product;
  const CartItemTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the cart notifier methods
    final cartNotifier = ref.read(cartProvider.notifier);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 10),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB12704), // Price color
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text('In Stock', style: TextStyle(color: Colors.green, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),

            // Quantity Controls and Delete Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  // Quantity Decrement Button
                  _buildQuantityButton(
                    icon: Icons.remove,
                    onPressed: () => cartNotifier.removeFromCart(product),
                    // Disable remove button if quantity is 1 (next press will remove the tile)
                    enabled: product.quantity > 0,
                  ),

                  // Quantity Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      product.quantity.toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Quantity Increment Button
                  _buildQuantityButton(
                    icon: Icons.add,
                    onPressed: () => cartNotifier.addToCart(product),
                    enabled: true, // Always allow adding more
                  ),

                  const Spacer(),

                  // Delete/Remove button
                  TextButton(
                    onPressed: () {
                      // Call the remover function until quantity is 0
                      for (int i = 0; i < product.quantity; i++) {
                        cartNotifier.removeFromCart(product);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} removed.')),
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed, required bool enabled}) {
    return Container(
      width: 40,
      height: 30,
      decoration: BoxDecoration(
        color: enabled ? Colors.grey.shade200 : Colors.grey.shade100,
        border: Border.all(color: enabled ? Colors.grey.shade400 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 20,
        icon: Icon(icon, color: enabled ? Colors.black : Colors.grey),
        onPressed: enabled ? onPressed : null,
      ),
    );
  }
}