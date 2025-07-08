import 'food_item.dart';

class CartItem {
  final FoodItem foodItem;
  int quantity;
  final String? specialInstructions;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => foodItem.price * quantity;

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodItem': foodItem.toJson(),
      'quantity': quantity,
      'specialInstructions': specialInstructions,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      foodItem: FoodItem.fromJson(json['foodItem']),
      quantity: json['quantity'],
      specialInstructions: json['specialInstructions'],
    );
  }
}
