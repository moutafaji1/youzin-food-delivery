import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeService extends GetxController {
  final RxBool _isDarkMode = true.obs;
  
  bool get isDarkMode => _isDarkMode.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? true;
      _isDarkMode.value = isDark;
      update();
    } catch (e) {
      print('Error loading theme: $e');
    }
  }
  
  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode.value);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _saveTheme();
    update();
    
    Get.snackbar(
      'تم التغيير',
      isDarkMode ? 'تم التبديل إلى الوضع المظلم' : 'تم التبديل إلى الوضع المضيء',
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.grey[200],
      colorText: isDarkMode ? const Color(0xFFFFD700) : Colors.black87,
      duration: const Duration(seconds: 2),
    );
  }
  
  // Colors for Dark Mode
  Color get backgroundColor => isDarkMode ? const Color(0xFF0F0F0F) : Colors.white;
  Color get cardColor => isDarkMode ? const Color(0xFF1A1A1A) : Colors.grey[100]!;
  Color get textColor => isDarkMode ? Colors.white : Colors.black87;
  Color get accentColor => const Color(0xFFFFD700); // Always gold
  Color get secondaryTextColor => isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
  Color get borderColor => isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[300]!;
  
  // Text Styles
  TextStyle get titleStyle => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  
  TextStyle get subtitleStyle => TextStyle(
    fontSize: 16,
    color: secondaryTextColor,
  );
  
  TextStyle get priceStyle => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: accentColor,
  );
}
