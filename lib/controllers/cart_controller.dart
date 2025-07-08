import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';

class CartController extends GetxController {
  final RxList<CartItem> _items = <CartItem>[].obs;
  static const double deliveryFee = 10.0; // 10 DH delivery fee

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get total => subtotal + deliveryFee;

  bool get isEmpty => _items.isEmpty;

  void addItem(FoodItem foodItem, {String? specialInstructions}) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.foodItem.id == foodItem.id &&
          item.specialInstructions == specialInstructions,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(
        CartItem(
          foodItem: foodItem,
          quantity: 1,
          specialInstructions: specialInstructions,
        ),
      );
    }
    update();
  }

  void removeItem(String foodItemId, {String? specialInstructions}) {
    _items.removeWhere(
      (item) =>
          item.foodItem.id == foodItemId &&
          item.specialInstructions == specialInstructions,
    );
    update();
  }

  void updateQuantity(
    String foodItemId,
    int quantity, {
    String? specialInstructions,
  }) {
    final index = _items.indexWhere(
      (item) =>
          item.foodItem.id == foodItemId &&
          item.specialInstructions == specialInstructions,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      update();
    }
  }

  void clearCart() {
    _items.clear();
    update();
  }

  String generateWhatsAppMessage() {
    if (_items.isEmpty) return '';

    String message = '🍽️ *طلب جديد من YouZine FOOD*\n\n';
    message += '📋 *تفاصيل الطلب:*\n';

    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      message += '${i + 1}. ${item.foodItem.name}\n';
      message += '   الكمية: ${item.quantity}\n';
      message += '   السعر: ${item.totalPrice.toStringAsFixed(2)} درهم\n';
      if (item.specialInstructions != null &&
          item.specialInstructions!.isNotEmpty) {
        message += '   ملاحظات: ${item.specialInstructions}\n';
      }
      message += '\n';
    }

    message += '💰 *ملخص الفاتورة:*\n';
    message += 'المجموع الفرعي: ${subtotal.toStringAsFixed(2)} درهم\n';
    message += 'رسوم التوصيل: ${deliveryFee.toStringAsFixed(2)} درهم\n';
    message += 'المجموع الكلي: ${total.toStringAsFixed(2)} درهم\n\n';
    message += '📞 يرجى تأكيد الطلب وإرسال العنوان للتوصيل';

    return message;
  }

  Future<void> sendWhatsAppMessage() async {
    final message = generateWhatsAppMessage();
    final phoneNumber = AppConstants.whatsappNumber;
    final whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
}
