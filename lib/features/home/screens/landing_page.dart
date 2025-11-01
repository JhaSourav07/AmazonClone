import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // For Consumer and ref.watch
import '../../../providers/cart_provider.dart';        // For cartTotalUnitsProvider
import '../../cart/screens/cart_screen.dart';          // For the navigation destination

import '../widgets/product_grid_view.dart';

// --- Constants (You'd put these in a separate file) ---
const Color kAppBarColor = Color(0xFF131921);
const Color kSearchColor = Color(0xFFFEBD69);
const Color kBackgroundColor = Color(0xFFE3E6E6);

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure for the screen
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // Use CustomScrollView to achieve a 'sticky' AppBar with a flexible layout
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. The main App Bar/Search Bar section (sticky at the top)
          SliverAppBar(
            elevation: 0,
            floating: true, // App bar should float when scrolling down
            snap: true, // App bar should fully reappear quickly
            backgroundColor: kAppBarColor,
            automaticallyImplyLeading: false, // No back button on the main page
            toolbarHeight: 60, // Standard height for just the search bar

            title: const AmazonSearchInput(), // The actual search bar widget

            actions: [
              Consumer(
                builder: (context, ref, child) {
                  final cartCount = ref.watch(cartTotalUnitsProvider); // Get total units

                  // REMOVE 'const' from IconButton
                  return IconButton(
                    // Use Badge.count to simplify
                    icon: Badge.count(
                      count: cartCount, // Pass int directly
                      isLabelVisible: cartCount > 0,
                      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      backgroundColor: const Color(0xFFB12704), // Red badge color
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const CartScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
            ],

            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50.0), // Height of the address bar
              child: AmazonAddressBar(), // The delivery address bar
            ),
          ),

          // 2. The main scrollable content of the page
      SliverList(
        delegate: SliverChildListDelegate(
          [
            // **Content Section 1: Top Carousel/Category Icons**
            const CategoryCarousel(),

            // **Content Section 2: Banner/Deal of the Day**
            const TopBanner(),

            // **Content Section 3: Product Grid (THE NEW WIDGET)**
            const ProductGridView(), // <--- Replace placeholder with this widget

            const SizedBox(height: 50), // Extra padding at the bottom
          ],
        ),
      ),
        ],
      ),
    );
  }
}

// --- Component 1: The Address Bar ---
class AmazonAddressBar extends StatelessWidget {
  const AmazonAddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xFF4ACFDD), // Amazon's teal color
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          const Icon(Icons.location_on_outlined, color: Colors.black, size: 20),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Deliver to John - New Delhi 110001',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    );
  }
}

// --- Component 2: The Search Input Field ---
class AmazonSearchInput extends StatelessWidget {
  const AmazonSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Material(
        elevation: 1, // Add shadow
        borderRadius: BorderRadius.circular(7),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 23,
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(top: 10),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.black38, width: 1),
            ),
            hintText: 'Search Amazon.in',
            hintStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            suffixIcon: const Icon(Icons.mic, color: Colors.black, size: 23),
          ),
        ),
      ),
    );
  }
}

// --- Component 3: Category Carousel Placeholder ---
class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.white,
      child: const Center(child: Text('Horizontal Category List (e.g., Mobiles, Fashion, Electronics)')),
    );
  }
}

// --- Component 4: Top Banner Placeholder ---
class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.grey,
        // In a real app, this would be a CarouselSlider displaying images
        //
      ),
      child: const Center(
        child: Text(
          'Image Slider / Top Promotional Banner',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}