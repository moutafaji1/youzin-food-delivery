import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/food_item.dart';
import 'simple_add_button.dart';
import 'food_image.dart';

class DarkFoodCard extends StatefulWidget {
  final FoodItem foodItem;

  const DarkFoodCard({super.key, required this.foodItem});

  @override
  State<DarkFoodCard> createState() => _DarkFoodCardState();
}

class _DarkFoodCardState extends State<DarkFoodCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final cardHeight = isSmallScreen ? 240.0 : 280.0;

    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _hoverController.forward(),
            onTapUp: (_) => _hoverController.reverse(),
            onTapCancel: () => _hoverController.reverse(),
            child: Container(
              height: cardHeight,
              margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 2 : 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF1A1A1A),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Row(
                  children: [
                    // Left side - Food Image
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: double.infinity,
                        child: FoodImage(
                          imageUrl: widget.foodItem.imageUrl,
                          category: widget.foodItem.category,
                          fit: BoxFit.cover,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),

                    // Right side - Food Details
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Badge and Availability
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    widget.foodItem.category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (!widget.foodItem.isAvailable)
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Food Name
                            Text(
                              widget.foodItem.name,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // Food Description
                            Text(
                              widget.foodItem.description,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.white60,
                              ),
                              maxLines: isSmallScreen ? 2 : 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),

                            // Price and Time
                            Row(
                              children: [
                                Text(
                                  '${widget.foodItem.price.toStringAsFixed(2)} درهم',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 16 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                if (widget.foodItem.preparationTime > 0)
                                  Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.clock,
                                        size: 14,
                                        color: Colors.white54,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${widget.foodItem.preparationTime} دقيقة',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Add Button
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: widget.foodItem.isAvailable
                                  ? SimpleAddButton(foodItem: widget.foodItem)
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
