import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/cart_item.dart';
import '../controllers/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: cartItem.foodItem.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.foodItem.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.foodItem.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${cartItem.totalPrice.toStringAsFixed(2)} درهم',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (cartItem.specialInstructions != null &&
                      cartItem.specialInstructions!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'ملاحظات: ${cartItem.specialInstructions}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              children: [
                GetBuilder<CartController>(
                  builder: (cart) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cartItem.quantity > 1) {
                              cart.updateQuantity(
                                cartItem.foodItem.id,
                                cartItem.quantity - 1,
                                specialInstructions:
                                    cartItem.specialInstructions,
                              );
                            } else {
                              cart.removeItem(
                                cartItem.foodItem.id,
                                specialInstructions:
                                    cartItem.specialInstructions,
                              );
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cart.updateQuantity(
                              cartItem.foodItem.id,
                              cartItem.quantity + 1,
                              specialInstructions: cartItem.specialInstructions,
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<CartController>(
                  builder: (cart) {
                    return GestureDetector(
                      onTap: () {
                        cart.removeItem(
                          cartItem.foodItem.id,
                          specialInstructions: cartItem.specialInstructions,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          size: 14,
                          color: Colors.red[400],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
