// lib/widgets/product_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/product_details/screens/product_details_screen.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart'; // We'll create this next!

class ProductItem extends ConsumerWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the cart state to know if this product is already in the cart
    final cartState = ref.watch(cartProvider);
    final inCart = cartState.any((item) => item.id == product.id);

    return GestureDetector(
      // onTap: () {
      //   // NAVIGATE TO THE DETAIL SCREEN, PASSING THE PRODUCT
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (ctx) => ProductDetailScreen(product: product),
      //     ),
      //   );
      // },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            // NAVIGATE TO THE DETAIL SCREEN, PASSING THE PRODUCT
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
              ),

              // Product Info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB12704), // Amazon red/orange price
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: inCart ? Colors.green : const Color(0xFFFFD814), // Amazon yellow button
                        ),
                        onPressed: () {
                          // Use .notifier to call methods on the StateNotifier
                          ref.read(cartProvider.notifier).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                inCart ? '${product.name} quantity updated!' : '${product.name} added to cart!',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(inCart ? Icons.check : Icons.shopping_cart),
                        label: Text(inCart ? 'IN CART' : 'Add to Cart', style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}