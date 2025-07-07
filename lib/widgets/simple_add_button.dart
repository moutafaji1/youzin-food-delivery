import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../models/food_item.dart';
import '../controllers/cart_controller.dart';

class SimpleAddButton extends StatefulWidget {
  final FoodItem foodItem;

  const SimpleAddButton({super.key, required this.foodItem});

  @override
  State<SimpleAddButton> createState() => _SimpleAddButtonState();
}

class _SimpleAddButtonState extends State<SimpleAddButton> {
  bool _isHovered = false;

  void _showQuantityDialog(BuildContext context) {
    int selectedQuantity = 1;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: const Color(0xFF1A1A1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      widget.foodItem.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Food image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.foodItem.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF333333),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.utensils,
                                size: 40,
                                color: Colors.white54,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Price
                    Text(
                      '${widget.foodItem.price.toStringAsFixed(2)} درهم',
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quantity selector
                    const Text(
                      'اختر الكمية:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Quantity buttons
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (int i = 1; i <= 10; i++)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedQuantity = i;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: selectedQuantity == i
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFFFFD700),
                                            Color(0xFFFFA500),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: selectedQuantity == i
                                      ? null
                                      : const Color(0xFF333333),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selectedQuantity == i
                                        ? const Color(0xFFFFA500)
                                        : const Color(0xFF555555),
                                    width: 2,
                                  ),
                                  boxShadow: selectedQuantity == i
                                      ? [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFFFA500,
                                            ).withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '$i',
                                    style: TextStyle(
                                      color: selectedQuantity == i
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Total price
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'المجموع:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '${(widget.foodItem.price * selectedQuantity).toStringAsFixed(2)} درهم',
                            style: const TextStyle(
                              color: Color(0xFFFFD700),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'إلغاء',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFD700),
                                    Color(0xFFFFA500),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFFA500,
                                    ).withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add to cart with selected quantity
                                  final cartController =
                                      Get.find<CartController>();
                                  for (int i = 0; i < selectedQuantity; i++) {
                                    cartController.addItem(widget.foodItem);
                                  }

                                  Get.back();

                                  // Show success feedback
                                  Get.snackbar(
                                    'تم بنجاح',
                                    'تم إضافة $selectedQuantity من ${widget.foodItem.name} إلى السلة',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    duration: const Duration(seconds: 2),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'إضافة إلى السلة',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return SizedBox(
      width: double.infinity,
      height: 45,
      child: widget.foodItem.isAvailable
          ? MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [const Color(0xFFFFE55C), const Color(0xFFFF8C00)]
                        : [const Color(0xFFFFD700), const Color(0xFFFFA500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isHovered
                                  ? const Color(0xFFFF8C00)
                                  : const Color(0xFFFFA500))
                              .withValues(alpha: 0.4),
                      blurRadius: _isHovered ? 12 : 6,
                      offset: Offset(0, _isHovered ? 4 : 2),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => _showQuantityDialog(context),
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    size: isSmallScreen ? 14 : 16,
                    color: Colors.black,
                  ),
                  label: Text(
                    isSmallScreen ? 'إضافة' : 'إضافة إلى السلة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Center(
                child: Text(
                  'غير متوفر',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}
