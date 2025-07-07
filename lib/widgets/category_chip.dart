import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  bool _isHovered = false;

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'الكل':
      case 'all':
        return FontAwesomeIcons.bowlFood;
      case 'برجر':
      case 'burger':
      case 'برغر':
        return FontAwesomeIcons.burger;
      case 'بيتزا':
      case 'pizza':
        return FontAwesomeIcons.pizzaSlice;
      case 'مشروبات':
      case 'drinks':
      case 'عصائر':
        return FontAwesomeIcons.bottleWater;
      case 'حلويات':
      case 'desserts':
      case 'حلوى':
        return FontAwesomeIcons.iceCream;
      case 'سلطات':
      case 'salads':
      case 'سلطة':
        return FontAwesomeIcons.seedling;
      case 'دجاج':
      case 'chicken':
        return FontAwesomeIcons.drumstickBite;
      case 'مأكولات بحرية':
      case 'seafood':
      case 'سمك':
        return FontAwesomeIcons.fish;
      case 'معجنات':
      case 'pastries':
      case 'فطائر':
        return FontAwesomeIcons.cookie;
      case 'قهوة':
      case 'coffee':
        return FontAwesomeIcons.mugHot;
      case 'شاورما':
      case 'shawarma':
        return FontAwesomeIcons.hotdog;
      case 'لحوم':
      case 'meat':
        return FontAwesomeIcons.cow;
      case 'مقبلات':
      case 'appetizers':
        return FontAwesomeIcons.bowlRice;
      case 'ساندويتش':
      case 'sandwich':
        return FontAwesomeIcons.breadSlice;
      default:
        return FontAwesomeIcons.bowlFood;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 24,
          vertical: isSmallScreen ? 10 : 14,
        ),
        decoration: BoxDecoration(
          gradient: widget.isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: widget.isSelected ? null : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFFFFD700)
                : const Color(0xFF333333),
            width: 2,
          ),
          boxShadow: [
            if (widget.isSelected) ...[
              // Main glow effect
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.6),
                spreadRadius: 4,
                blurRadius: 12,
                offset: const Offset(0, 0),
              ),
              // Secondary glow
              BoxShadow(
                color: const Color(0xFFFFA500).withValues(alpha: 0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
              // Inner glow
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] else ...[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              _getCategoryIcon(widget.label),
              size: isSmallScreen ? 16 : 18,
              color: widget.isSelected ? Colors.black : const Color(0xFFFFD700),
            ),
            SizedBox(width: isSmallScreen ? 6 : 8),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 14 : 16,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
