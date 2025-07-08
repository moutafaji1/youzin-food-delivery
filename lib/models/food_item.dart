class FoodSize {
  final String name;
  final double price;
  final String description;

  FoodSize({
    required this.name,
    required this.price,
    required this.description,
  });
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String restaurant;
  final bool isAvailable;
  final List<String> ingredients;
  final int preparationTime; // in minutes
  final List<FoodSize>? sizes; // Optional sizes

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.restaurant,
    this.isAvailable = true,
    this.ingredients = const [],
    this.preparationTime = 15,
    this.sizes,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      restaurant: json['restaurant'] ?? 'YouZin Food',
      isAvailable: json['isAvailable'] ?? true,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      preparationTime: json['preparationTime'] ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'restaurant': restaurant,
      'isAvailable': isAvailable,
      'ingredients': ingredients,
      'preparationTime': preparationTime,
    };
  }
}
