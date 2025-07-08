import 'package:flutter/material.dart';

abstract class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
  ];

  static const List<Locale> supportedLocales = [Locale('ar'), Locale('fr')];

  // App Title
  String get appTitle;
  String get appSubtitle;

  // Navigation
  String get home;
  String get cart;
  String get search;

  // Food Categories
  String get burgers;
  String get pizza;
  String get drinks;
  String get desserts;
  String get salads;
  String get sandwiches;

  // Actions
  String get addToCart;
  String get orderNow;
  String get getStarted;
  String get contactUs;

  // Cart
  String get yourCart;
  String get emptyCart;
  String get emptyCartMessage;
  String get total;
  String get deliveryFee;
  String get orderSummary;
  String get quantity;

  // Common
  String get available;
  String get unavailable;
  String get dh;
  String get mostPopular;
  String get featuredItems;

  // Messages
  String get itemAddedToCart;
  String get orderSentSuccessfully;

  // Search
  String get searchHint;
  String get noResultsFound;

  // Welcome
  String get welcomeMessage;
  String get welcomeSubtitle;

  // Common Actions
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'ar':
        return AppLocalizationsAr();
      case 'fr':
        return AppLocalizationsFr();
      default:
        return AppLocalizationsAr();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}

class AppLocalizationsAr extends AppLocalizations {
  @override
  String get appTitle => 'YouZin FOOD';

  @override
  String get appSubtitle => 'أفضل طعام في المدينة';

  @override
  String get home => 'الرئيسية';

  @override
  String get cart => 'السلة';

  @override
  String get search => 'البحث';

  @override
  String get burgers => 'برجر';

  @override
  String get pizza => 'بيتزا';

  @override
  String get drinks => 'مشروبات';

  @override
  String get desserts => 'حلويات';

  @override
  String get salads => 'سلطات';

  @override
  String get sandwiches => 'ساندويتش';

  @override
  String get addToCart => 'أضف للسلة';

  @override
  String get orderNow => 'اطلب الآن';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get yourCart => 'سلتك';

  @override
  String get emptyCart => 'السلة فارغة';

  @override
  String get emptyCartMessage => 'لم تقم بإضافة أي عناصر بعد';

  @override
  String get total => 'المجموع';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get quantity => 'الكمية';

  @override
  String get available => 'متوفر';

  @override
  String get unavailable => 'غير متوفر';

  @override
  String get dh => 'درهم';

  @override
  String get mostPopular => 'الأكثر شعبية';

  @override
  String get featuredItems => 'العناصر المميزة';

  @override
  String get itemAddedToCart => 'تم إضافة العنصر للسلة';

  @override
  String get orderSentSuccessfully => 'تم إرسال الطلب بنجاح';

  @override
  String get searchHint => 'ابحث عن الطعام...';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get welcomeMessage => 'مرحباً بك في YouZin FOOD';

  @override
  String get welcomeSubtitle => 'اكتشف أفضل الأطعمة في المدينة';

  @override
  String get close => 'إغلاق';
}

class AppLocalizationsFr extends AppLocalizations {
  @override
  String get appTitle => 'YouZin FOOD';

  @override
  String get appSubtitle => 'La meilleure nourriture en ville';

  @override
  String get home => 'Accueil';

  @override
  String get cart => 'Panier';

  @override
  String get search => 'Recherche';

  @override
  String get burgers => 'Burgers';

  @override
  String get pizza => 'Pizza';

  @override
  String get drinks => 'Boissons';

  @override
  String get desserts => 'Desserts';

  @override
  String get salads => 'Salades';

  @override
  String get sandwiches => 'Sandwichs';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String get orderNow => 'Commander maintenant';

  @override
  String get getStarted => 'Commencer';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get yourCart => 'Votre panier';

  @override
  String get emptyCart => 'Panier vide';

  @override
  String get emptyCartMessage => 'Vous n\'avez ajouté aucun article';

  @override
  String get total => 'Total';

  @override
  String get deliveryFee => 'Frais de livraison';

  @override
  String get orderSummary => 'Résumé de commande';

  @override
  String get quantity => 'Quantité';

  @override
  String get available => 'Disponible';

  @override
  String get unavailable => 'Indisponible';

  @override
  String get dh => 'DH';

  @override
  String get mostPopular => 'Plus populaire';

  @override
  String get featuredItems => 'Articles vedettes';

  @override
  String get itemAddedToCart => 'Article ajouté au panier';

  @override
  String get orderSentSuccessfully => 'Commande envoyée avec succès';

  @override
  String get searchHint => 'Rechercher de la nourriture...';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get welcomeMessage => 'Bienvenue chez YouZin FOOD';

  @override
  String get welcomeSubtitle => 'Découvrez la meilleure nourriture en ville';

  @override
  String get close => 'Fermer';
}
