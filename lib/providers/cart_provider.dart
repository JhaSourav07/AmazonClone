// lib/providers/cart_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart'; // Import the immutable Product model

// 1. Define the Cart Notifier
// It manages the list of Product objects in the cart state.
class CartNotifier extends StateNotifier<List<Product>> {
  // Initialize the state with an empty list of products
  CartNotifier() : super([]);

  // Add a product to the cart or increment its quantity
  void addToCart(Product product) {
    // 1. Find the index of the existing product (if any)
    final existingIndex = state.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      // **A. Product Exists: Increment Quantity**

      // 1. Create a copy of the list (ensures list immutability)
      final newState = List<Product>.from(state);

      // 2. Create a copy of the existing product with an incremented quantity
      final updatedProduct = newState[existingIndex].copyWith(
        quantity: newState[existingIndex].quantity + 1,
      );

      // 3. Replace the old product with the updated copy
      newState[existingIndex] = updatedProduct;

      // 4. Update the state with the new list
      state = newState;
    } else {
      // **B. Product is New: Add it with quantity 1**

      // Create a copy of the new product, setting its quantity to 1
      final newProductWithQuantity = product.copyWith(quantity: 1);

      // Update the state by creating a new list with the new product added
      state = [...state, newProductWithQuantity];
    }
  }

  // Remove a product or decrease quantity
  void removeFromCart(Product product) {
    final existingIndex = state.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      final currentQuantity = state[existingIndex].quantity;

      if (currentQuantity > 1) {
        // **A. Quantity > 1: Decrement Quantity**

        // 1. Create a copy of the list
        final newState = List<Product>.from(state);

        // 2. Create a copy of the product with the decremented quantity
        final updatedProduct = newState[existingIndex].copyWith(
          quantity: currentQuantity - 1,
        );

        // 3. Replace the old product with the updated copy
        newState[existingIndex] = updatedProduct;

        // 4. Update the state
        state = newState;

      } else {
        // **B. Quantity == 1: Remove the product entirely**
        state = state.where((item) => item.id != product.id).toList();
      }
    }
  }

  // Clear the entire cart
  void clearCart() {
    state = [];
  }

  // Calculate the total cost of all items in the cart (Read-only getter)
  double get totalAmount {
    double total = 0.0;
    for (var item in state) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

// 2. Define the global provider
// This allows UI widgets to access the CartNotifier and listen to its state
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

// A simple provider to get the total number of items in the cart
final cartCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.length; // Returns the number of unique product types
});

// A provider to get the total count of all units (e.g., 2 shirts + 3 pants = 5 units)
final cartTotalUnitsProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});