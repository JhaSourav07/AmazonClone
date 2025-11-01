import 'package:flutter/material.dart';
import '../../../dummy_data.dart'; // Import dummy data
import '../../../widgets/product_item.dart'; // Import the item widget

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Title for the section
    const sectionTitle = Padding(
      padding: EdgeInsets.only(top: 15.0, left: 12.0, right: 12.0, bottom: 10.0),
      child: Text(
        'Top Picks for You',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );

    // 2. The main grid view
    final productGrid = GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Important: to allow parent CustomScrollView to scroll
      shrinkWrap: true, // Important: allows the grid to take only the size of its content
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7, // Adjust height vs width of the product card
      ),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        return ProductItem(product: dummyProducts[index]);
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle,
        productGrid,
      ],
    );
  }
}