import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/favorites_service.dart';
import 'package:get/get.dart';
import 'quantity_selector_dialog.dart';

class ModernFoodGrid extends StatelessWidget {
  final List<FoodItem> foodItems;

  const ModernFoodGrid({super.key, required this.foodItems});

  // Different gradient colors for variety
  List<List<Color>> get gradientColors => [
    [const Color(0xFF4CAF50), const Color(0xFF2E7D32)], // Green
    [const Color(0xFF2196F3), const Color(0xFF1565C0)], // Blue
    [const Color(0xFF9C27B0), const Color(0xFF6A1B9A)], // Purple
    [const Color(0xFFFF9800), const Color(0xFFE65100)], // Orange
    [const Color(0xFFF44336), const Color(0xFFC62828)], // Red
    [const Color(0xFF00BCD4), const Color(0xFF00838F)], // Cyan
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final foodItem = foodItems[index];
        final colors = gradientColors[index % gradientColors.length];

        return ModernFoodGridCard(foodItem: foodItem, gradientColors: colors);
      },
    );
  }
}

class ModernFoodGridCard extends StatefulWidget {
  final FoodItem foodItem;
  final List<Color> gradientColors;

  const ModernFoodGridCard({
    super.key,
    required this.foodItem,
    required this.gradientColors,
  });

  @override
  State<ModernFoodGridCard> createState() => _ModernFoodGridCardState();
}

class _ModernFoodGridCardState extends State<ModernFoodGridCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final FavoritesService _favoritesService = Get.find<FavoritesService>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Get.dialog(QuantitySelectorDialog(foodItem: widget.foodItem));
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradientColors.first.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Food Image
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: widget.foodItem.imageUrl,
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.white.withOpacity(0.2),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.white.withOpacity(0.2),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button
                  Positioned(
                    top: 24,
                    right: 24,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          _favoritesService.toggleFavorite(widget.foodItem);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FaIcon(
                            _favoritesService.isFavorite(widget.foodItem.id)
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color:
                                _favoritesService.isFavorite(widget.foodItem.id)
                                ? Colors.red
                                : Colors.grey[600],
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Food Details
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food Name
                        Text(
                          widget.foodItem.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Restaurant Name
                        Text(
                          '${widget.foodItem.preparationTime} دقيقة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),

                        // Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Price
                            Text(
                              '${widget.foodItem.price.toStringAsFixed(0)} MAD',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
