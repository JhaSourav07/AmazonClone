// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final double rating;
  final int quantity; // Made 'final' (immutable)

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.rating = 0.0,
    this.quantity = 0,
  });

  // ******* CRITICAL ADDITION: The copyWith method *******
  // This allows us to create a new Product instance based on an old one,
  // changing only the specified properties (like quantity).
  Product copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? description,
    double? rating,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }

// (Your existing factory constructor can remain here)
}