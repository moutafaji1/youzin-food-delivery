import 'package:get/get.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

class CartService extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  final RxDouble _deliveryFee = 10.0.obs;

  List<CartItem> get cartItems => _cartItems;
  double get deliveryFee => _deliveryFee.value;

  double get subtotal {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + (item.foodItem.price * item.quantity),
    );
  }

  double get total => subtotal + deliveryFee;

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(FoodItem foodItem) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = CartItem(
        foodItem: foodItem,
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      _cartItems.add(CartItem(foodItem: foodItem, quantity: 1));
    }

    update();
  }

  void removeFromCart(String foodItemId) {
    _cartItems.removeWhere((item) => item.foodItem.id == foodItemId);
    update();
  }

  void removeOneFromCart(FoodItem foodItem) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex != -1) {
      if (_cartItems[existingIndex].quantity > 1) {
        _cartItems[existingIndex] = CartItem(
          foodItem: foodItem,
          quantity: _cartItems[existingIndex].quantity - 1,
        );
      } else {
        _cartItems.removeAt(existingIndex);
      }
      update();
    }
  }

  void updateQuantity(String foodItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(foodItemId);
      return;
    }

    final index = _cartItems.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );
    if (index != -1) {
      _cartItems[index] = CartItem(
        foodItem: _cartItems[index].foodItem,
        quantity: quantity,
      );
      update();
    }
  }

  void clearCart() {
    _cartItems.clear();
    update();
  }

  bool isInCart(String foodItemId) {
    return _cartItems.any((item) => item.foodItem.id == foodItemId);
  }

  int getQuantity(String foodItemId) {
    final item = _cartItems.firstWhereOrNull(
      (item) => item.foodItem.id == foodItemId,
    );
    return item?.quantity ?? 0;
  }
}
