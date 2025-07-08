import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'food_placeholder.dart';

class FoodImage extends StatelessWidget {
  final String imageUrl;
  final String? category;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const FoodImage({
    super.key,
    required this.imageUrl,
    this.category,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  Widget _buildPlaceholder() {
    return FoodPlaceholder(
      category: category ?? 'الكل',
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  Widget _buildErrorWidget() {
    return FoodPlaceholder(
      category: category ?? 'الكل',
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if it's a local asset
    if (imageUrl.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        ),
      );
    }

    // Network image with caching
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 100),
      ),
    );
  }
}
