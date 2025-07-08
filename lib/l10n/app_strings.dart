import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/language_controller.dart';

class AppStrings {
  static String get(BuildContext context, String key) {
    final languageController = Get.find<LanguageController>();
    return languageController.isArabic
        ? _arabic[key] ?? key
        : _french[key] ?? key;
  }

  static const Map<String, String> _arabic = {
    'app_title': 'YouZin Food',
    'app_subtitle': 'أفضل طعام في المدينة',
    'home': 'الرئيسية',
    'cart': 'السلة',
    'search': 'البحث',
    'burgers': 'برجر',
    'pizza': 'بيتزا',
    'drinks': 'مشروبات',
    'desserts': 'حلويات',
    'salads': 'سلطات',
    'sandwiches': 'ساندويتش',
    'all': 'الكل',
    'add_to_cart': 'أضف للسلة',
    'order_now': 'اطلب الآن',
    'get_started': 'ابدأ الآن',
    'contact_us': 'اتصل بنا',
    'your_cart': 'سلتك',
    'empty_cart': 'السلة فارغة',
    'empty_cart_message': 'لم تقم بإضافة أي عناصر بعد',
    'total': 'المجموع',
    'delivery_fee': 'رسوم التوصيل',
    'order_summary': 'ملخص الطلب',
    'quantity': 'الكمية',
    'available': 'متوفر',
    'unavailable': 'غير متوفر',
    'dh': 'درهم',
    'most_popular': 'الأكثر طلباً',
    'featured_items': 'العناصر المميزة',
    'item_added_to_cart': 'تم إضافة العنصر للسلة',
    'order_sent_successfully': 'تم إرسال الطلب بنجاح',
    'search_hint': 'ابحث عن طبقك المفضل...',
    'no_results_found': 'لم يتم العثور على نتائج',
    'welcome_message': 'مرحباً بك في YouZin FOOD',
    'welcome_subtitle': 'اكتشف أفضل الأطعمة في المدينة',
    'close': 'إغلاق',
  };

  static const Map<String, String> _french = {
    'app_title': 'YouZin Food',
    'app_subtitle': 'La meilleure nourriture en ville',
    'home': 'Accueil',
    'cart': 'Panier',
    'search': 'Recherche',
    'burgers': 'Burgers',
    'pizza': 'Pizza',
    'drinks': 'Boissons',
    'desserts': 'Desserts',
    'salads': 'Salades',
    'sandwiches': 'Sandwichs',
    'all': 'Tout',
    'add_to_cart': 'Ajouter au panier',
    'order_now': 'Commander maintenant',
    'get_started': 'Commencer',
    'contact_us': 'Nous contacter',
    'your_cart': 'Votre panier',
    'empty_cart': 'Panier vide',
    'empty_cart_message': 'Vous n\'avez ajouté aucun article',
    'total': 'Total',
    'delivery_fee': 'Frais de livraison',
    'order_summary': 'Résumé de commande',
    'quantity': 'Quantité',
    'available': 'Disponible',
    'unavailable': 'Indisponible',
    'dh': 'DH',
    'most_popular': 'Plus populaire',
    'featured_items': 'Articles vedettes',
    'item_added_to_cart': 'Article ajouté au panier',
    'order_sent_successfully': 'Commande envoyée avec succès',
    'search_hint': 'Rechercher de la nourriture...',
    'no_results_found': 'Aucun résultat trouvé',
    'welcome_message': 'Bienvenue chez YouZin FOOD',
    'welcome_subtitle': 'Découvrez la meilleure nourriture en ville',
    'close': 'Fermer',
  };
}
