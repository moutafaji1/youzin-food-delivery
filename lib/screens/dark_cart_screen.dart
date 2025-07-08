import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/cart_service.dart';

class DarkCartScreen extends StatelessWidget {
  const DarkCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: GetBuilder<CartService>(
          builder: (cartService) {
            if (cartService.cartItems.isEmpty) {
              return _buildEmptyCart(context);
            }

            return Column(
              children: [
                // Header
                _buildHeader(context),

                // Cart Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cartService.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartService.cartItems[index];
                      return _buildCartItem(item, cartService);
                    },
                  ),
                ),

                // Order Summary
                _buildOrderSummary(cartService),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFFFD700),
                size: 18,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Title
          const Text(
            'Mon Panier',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 20),
                Text(
                  'Votre panier est vide',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Continuer les achats',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(item, CartService cartService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Food Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodItem.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.foodItem.price.toStringAsFixed(0)} MAD',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFFD700),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              GestureDetector(
                onTap: () => cartService.removeOneFromCart(item.foodItem),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),

              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => cartService.addToCart(item.foodItem),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartService cartService) {
    final subtotal = cartService.subtotal;
    const deliveryFee = 10.0;
    final total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résumé de la Commande',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sous-total',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              ),
              Text(
                '${subtotal.toStringAsFixed(2)} MAD',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Delivery Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frais de livraison',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              ),
              Text(
                '${deliveryFee.toStringAsFixed(2)} MAD',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(color: Color(0xFF2A2A2A)),

          const SizedBox(height: 20),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${total.toStringAsFixed(2)} MAD',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Order Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _sendOrderToWhatsApp(cartService),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Commander',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendOrderToWhatsApp(CartService cartService) async {
    String orderText = "🍽️ *طلب جديد من YouZin FOOD*\n\n";

    orderText += "📋 *تفاصيل الطلب:*\n";

    for (var item in cartService.cartItems) {
      orderText += "${item.quantity}. ${item.foodItem.name}\n";
      orderText += "الكمية: ${item.quantity}\n";
      orderText +=
          "السعر: ${(item.foodItem.price * item.quantity).toStringAsFixed(2)} درهم\n\n";
    }

    orderText += "💰 *ملخص الفاتورة:*\n";
    orderText +=
        "المجموع الفرعي: ${cartService.subtotal.toStringAsFixed(2)} درهم\n";
    orderText += "رسوم التوصيل: 10.00 درهم\n";
    orderText +=
        "المجموع الكلي: ${(cartService.subtotal + 10).toStringAsFixed(2)} درهم\n\n";
    orderText += "📞 يرجى تأكيد الطلب وإرسال العنوان للتوصيل";

    final phoneNumber = "+212777149406"; // رقم WhatsApp الخاص بك
    final whatsappUrl =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(orderText)}";

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(
          Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'خطأ',
          'لا يمكن فتح WhatsApp',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ في إرسال الطلب',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
