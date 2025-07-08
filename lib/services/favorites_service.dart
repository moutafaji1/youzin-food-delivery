import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FavoritesService extends GetxController {
  final RxList<String> _favoriteIds = <String>[].obs;

  List<String> get favoriteIds => _favoriteIds;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites') ?? [];
      _favoriteIds.assignAll(favorites);
      update();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favoriteIds);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  bool isFavorite(String foodItemId) {
    return _favoriteIds.contains(foodItemId);
  }

  void toggleFavorite(FoodItem foodItem) {
    if (isFavorite(foodItem.id)) {
      _favoriteIds.remove(foodItem.id);
      Get.snackbar(
        'تم الحذف',
        'تم حذف ${foodItem.name} من المفضلة',
        backgroundColor: const Color(0xFF1A1A1A),
        colorText: const Color(0xFFFFD700),
        duration: const Duration(seconds: 2),
      );
    } else {
      _favoriteIds.add(foodItem.id);
      Get.snackbar(
        'تم الإضافة',
        'تم إضافة ${foodItem.name} إلى المفضلة',
        backgroundColor: const Color(0xFF1A1A1A),
        colorText: const Color(0xFFFFD700),
        duration: const Duration(seconds: 2),
      );
    }
    _saveFavorites();
    update();
  }

  void addToFavorites(FoodItem foodItem) {
    if (!isFavorite(foodItem.id)) {
      _favoriteIds.add(foodItem.id);
      update();
    }
  }

  void removeFromFavorites(String foodItemId) {
    _favoriteIds.remove(foodItemId);
    update();
  }

  void clearFavorites() {
    _favoriteIds.clear();
    update();
  }

  List<FoodItem> getFavoriteItems(List<FoodItem> allItems) {
    return allItems.where((item) => isFavorite(item.id)).toList();
  }
}
