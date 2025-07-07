import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/language_controller.dart';
import 'screens/home_screen.dart';

void main() {
  // Initialize GetX Controllers
  Get.put(CartController());
  Get.put(ThemeController());
  Get.put(LanguageController());

  runApp(const YouZineFoodApp());
}

class YouZineFoodApp extends StatelessWidget {
  const YouZineFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LanguageController>(
          builder: (languageController) {
            return GetMaterialApp(
              title: 'YouZin Food',
              debugShowCheckedModeBanner: false,
              theme: themeController.lightTheme,
              darkTheme: themeController.darkTheme,
              themeMode: themeController.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              locale: const Locale('ar', 'SA'),
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: child!,
                );
              },
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
