import 'package:flutter/material.dart';

class AppConstants {
  // LUX Colors - Light Theme
  static const Color primaryColor = Color(0xFF6366F1); // Indigo
  static const Color secondaryColor = Color(0xFF8B5CF6); // Purple
  static const Color accentColor = Color(0xFFEC4899); // Pink
  static const Color goldColor = Color(0xFFF59E0B); // Gold
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color cardColor = Colors.white;
  static const Color textPrimaryColor = Color(0xFF1F2937);
  static const Color textSecondaryColor = Color(0xFF6B7280);
  static const Color successColor = Color(0xFF10B981); // Emerald
  static const Color errorColor = Color(0xFFEF4444);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF818CF8); // Light Indigo
  static const Color darkSecondaryColor = Color(0xFFA78BFA); // Light Purple
  static const Color darkAccentColor = Color(0xFFF472B6); // Light Pink
  static const Color darkGoldColor = Color(0xFFFBBF24); // Light Gold
  static const Color darkBackgroundColor = Color(0xFF111827);
  static const Color darkCardColor = Color(0xFF1F2937);
  static const Color darkTextPrimaryColor = Color(0xFFF9FAFB);
  static const Color darkTextSecondaryColor = Color(0xFFD1D5DB);
  static const Color darkSuccessColor = Color(0xFF34D399);
  static const Color darkErrorColor = Color(0xFFF87171);

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 20.0;
  static const double fontSizeTitle = 24.0;

  // App Settings
  static const double deliveryFee = 10.0;
  static const String whatsappNumber = '+212777149406'; // Your WhatsApp number
  static const String instagramHandle = '@youzin_food'; // Instagram handle
  static const String appName = 'YouZine FOOD';
  static const String appSlogan = 'اطلب ألذ الوجبات واستمتع بالطعم الرائع';

  // Animation Durations
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // Grid Settings
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  static const double gridSpacing = 16.0;
}

class AppStrings {
  // Arabic Strings
  static const String welcome = 'مرحباً بك في YouZine FOOD';
  static const String slogan = 'اطلب ألذ الوجبات واستمتع بالطعم الرائع';
  static const String freeDelivery = 'توصيل مجاني للطلبات أكثر من 100 درهم';
  static const String cart = 'سلة المشتريات';
  static const String emptyCart = 'سلة المشتريات فارغة';
  static const String emptyCartMessage = 'أضف بعض العناصر اللذيذة إلى سلتك';
  static const String browseMenu = 'تصفح القائمة';
  static const String subtotal = 'المجموع الفرعي:';
  static const String deliveryFee = 'رسوم التوصيل:';
  static const String total = 'المجموع الكلي:';
  static const String sendWhatsApp = 'إرسال الطلب عبر واتساب';
  static const String addedToCart = 'تم إضافة المنتج إلى السلة';
  static const String orderError = 'خطأ في إرسال الطلب';
  static const String noItemsInCategory = 'لا توجد عناصر في هذه الفئة';
  static const String minutes = 'دقيقة';
  static const String currency = 'درهم';
  static const String notes = 'ملاحظات:';
  static const String all = 'الكل';

  // Categories
  static const String burgers = 'برجر';
  static const String pizza = 'بيتزا';
  static const String sandwiches = 'ساندويش';
  static const String drinks = 'مشروبات';
  static const String desserts = 'حلويات';
}

class AppImages {
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderFood = 'assets/images/placeholder_food.png';
  static const String emptyCart = 'assets/images/empty_cart.png';
}
