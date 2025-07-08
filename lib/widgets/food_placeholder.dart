import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodPlaceholder extends StatelessWidget {
  final String category;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const FoodPlaceholder({
    super.key,
    required this.category,
    this.width,
    this.height,
    this.borderRadius,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'برجر':
      case 'burger':
        return FontAwesomeIcons.burger;
      case 'بيتزا':
      case 'pizza':
        return FontAwesomeIcons.pizzaSlice;
      case 'مشروبات':
      case 'drinks':
        return FontAwesomeIcons.glassWater;
      case 'حلويات':
      case 'desserts':
        return FontAwesomeIcons.cakeCandles;
      case 'سلطات':
      case 'salads':
        return FontAwesomeIcons.leaf;
      case 'دجاج':
      case 'chicken':
        return FontAwesomeIcons.drumstickBite;
      case 'مأكولات بحرية':
      case 'seafood':
        return FontAwesomeIcons.fish;
      case 'معجنات':
      case 'pastries':
        return FontAwesomeIcons.breadSlice;
      default:
        return FontAwesomeIcons.utensils;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'برجر':
      case 'burger':
        return const Color(0xFFFF6B35);
      case 'بيتزا':
      case 'pizza':
        return const Color(0xFFE74C3C);
      case 'مشروبات':
      case 'drinks':
        return const Color(0xFF3498DB);
      case 'حلويات':
      case 'desserts':
        return const Color(0xFFE91E63);
      case 'سلطات':
      case 'salads':
        return const Color(0xFF4CAF50);
      case 'دجاج':
      case 'chicken':
        return const Color(0xFFFF9800);
      case 'مأكولات بحرية':
      case 'seafood':
        return const Color(0xFF00BCD4);
      case 'معجنات':
      case 'pastries':
        return const Color(0xFF8BC34A);
      default:
        return const Color(0xFFFFD700);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withValues(alpha: 0.8),
            categoryColor.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: PatternPainter(color: Colors.white.withValues(alpha: 0.1)),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  categoryIcon,
                  color: Colors.white,
                  size: width != null ? width! * 0.2 : 40,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'YouZin Food',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  final Color color;

  PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 20.0;
    
    // Draw diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
