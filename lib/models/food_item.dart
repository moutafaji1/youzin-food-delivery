class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final List<String> ingredients;
  final int preparationTime; // in minutes

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isAvailable = true,
    this.ingredients = const [],
    this.preparationTime = 15,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
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
      'isAvailable': isAvailable,
      'ingredients': ingredients,
      'preparationTime': preparationTime,
    };
  }
}
