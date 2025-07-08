import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ThemeController extends GetxController {
  final RxBool _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _saveThemeToPrefs();
    update();
  }

  void _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    update();
  }

  void _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode.value);
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      cardColor: AppConstants.cardColor,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.light,
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        tertiary: AppConstants.accentColor,
        surface: AppConstants.cardColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppConstants.textPrimaryColor,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppConstants.cardColor,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppConstants.primaryColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppConstants.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppConstants.textPrimaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeXXLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeLarge,
          color: AppConstants.textPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          color: AppConstants.textSecondaryColor,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppConstants.darkPrimaryColor,
      scaffoldBackgroundColor: AppConstants.darkBackgroundColor,
      cardColor: AppConstants.darkCardColor,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.darkPrimaryColor,
        brightness: Brightness.dark,
        primary: AppConstants.darkPrimaryColor,
        secondary: AppConstants.darkSecondaryColor,
        tertiary: AppConstants.darkAccentColor,
        surface: AppConstants.darkCardColor,
        onPrimary: AppConstants.darkBackgroundColor,
        onSecondary: AppConstants.darkBackgroundColor,
        onSurface: AppConstants.darkTextPrimaryColor,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.darkCardColor,
        foregroundColor: AppConstants.darkTextPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppConstants.darkTextPrimaryColor,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppConstants.darkCardColor,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.darkPrimaryColor,
          foregroundColor: AppConstants.darkBackgroundColor,
          elevation: 2,
          shadowColor: AppConstants.darkPrimaryColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppConstants.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppConstants.darkTextPrimaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeXXLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.darkTextPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeLarge,
          color: AppConstants.darkTextPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          color: AppConstants.darkTextSecondaryColor,
        ),
      ),
    );
  }
}
