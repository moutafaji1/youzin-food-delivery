import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final Rx<Locale> _currentLocale = const Locale('ar').obs; // Default to Arabic

  Locale get currentLocale => _currentLocale.value;

  bool get isArabic => _currentLocale.value.languageCode == 'ar';
  bool get isFrench => _currentLocale.value.languageCode == 'fr';

  void setLocale(Locale locale) {
    if (_currentLocale.value != locale) {
      _currentLocale.value = locale;
      update();
    }
  }

  void toggleLanguage() {
    if (_currentLocale.value.languageCode == 'ar') {
      setLocale(const Locale('fr'));
    } else {
      setLocale(const Locale('ar'));
    }
  }

  void setArabic() {
    setLocale(const Locale('ar'));
  }

  void setFrench() {
    setLocale(const Locale('fr'));
  }
}
