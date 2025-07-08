import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import '../services/theme_service.dart';
import '../widgets/simple_dark_card.dart';
import 'dark_food_detail_screen.dart';
import 'dark_cart_screen.dart';

class DarkHomeScreen extends StatefulWidget {
  const DarkHomeScreen({super.key});

  @override
  State<DarkHomeScreen> createState() => _DarkHomeScreenState();
}

class _DarkHomeScreenState extends State<DarkHomeScreen> {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Tacos',
    'Pizza',
    'Burger',
    'Sushi',
    'Dessert',
    'Drinks',
  ];

  final List<FoodItem> foodItems = [
    FoodItem(
      id: '1',
      name: 'Tacos Spécial YOUZIN',
      description:
          'Un mélange exquis de viandes marinées, frites maison, et notre sauce secrète.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=500',
      category: 'Tacos',
      restaurant: 'YouZin Food',
      preparationTime: 18,
    ),
    FoodItem(
      id: '2',
      name: 'Pizza Margherita',
      description: 'Pizza classique avec tomate, mozzarella et basilic frais',
      price: 85.00,
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=500',
      category: 'Pizza',
      restaurant: 'YouZin Food',
      preparationTime: 25,
    ),
    FoodItem(
      id: '3',
      name: 'Burger Deluxe',
      description: 'Burger premium avec steak, fromage, salade et frites',
      price: 65.00,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
      category: 'Burger',
      restaurant: 'YouZin Food',
      preparationTime: 20,
    ),
    FoodItem(
      id: '4',
      name: 'Sushi Mix Premium',
      description:
          'Assortiment de sushi frais du jour avec wasabi et gingembre',
      price: 120.00,
      imageUrl:
          'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=500',
      category: 'Sushi',
      restaurant: 'YouZin Food',
      preparationTime: 15,
    ),
    FoodItem(
      id: '5',
      name: 'Tacos Chicken',
      description: 'Tacos au poulet grillé avec légumes frais et sauce épicée',
      price: 40.00,
      imageUrl:
          'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=500',
      category: 'Tacos',
      restaurant: 'YouZin Food',
      preparationTime: 15,
    ),
    FoodItem(
      id: '6',
      name: 'Pizza 4 Fromages',
      description: 'Pizza aux quatre fromages fondants sur pâte artisanale',
      price: 95.00,
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      category: 'Pizza',
      restaurant: 'YouZin Food',
      preparationTime: 28,
    ),
  ];

  List<FoodItem> get filteredItems {
    List<FoodItem> items = selectedCategory == 'All'
        ? foodItems
        : foodItems.where((item) => item.category == selectedCategory).toList();

    if (searchQuery.isNotEmpty) {
      items = items
          .where(
            (item) =>
                item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                item.description.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return items;
  }

  void _openInstagram() async {
    const instagramUrl =
        'https://www.instagram.com/youzin_food?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';

    try {
      if (await canLaunchUrl(Uri.parse(instagramUrl))) {
        await launchUrl(
          Uri.parse(instagramUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'خطأ',
          'لا يمكن فتح Instagram',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ في فتح الرابط',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeService>(
      builder: (themeService) {
        return Scaffold(
          backgroundColor: themeService.backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Header with Logo and Cart
                _buildHeader(),

                // Search Bar
                _buildSearchBar(),

                // Categories
                _buildCategories(),

                // Food Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return SimpleDarkCard(
                        foodItem: filteredItems[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DarkFoodDetailScreen(
                                foodItem: filteredItems[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return GetBuilder<ThemeService>(
      builder: (themeService) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Logo
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'YouZin',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFD700),
                        ),
                      ),
                      TextSpan(
                        text: ' FOOD',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeService.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Theme Toggle Button
              GetBuilder<ThemeService>(
                builder: (themeService) {
                  return IconButton(
                    onPressed: () => themeService.toggleTheme(),
                    icon: Icon(
                      themeService.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: const Color(0xFFFFD700),
                      size: 24,
                    ),
                  );
                },
              ),

              // Instagram Icon
              IconButton(
                onPressed: () => _openInstagram(),
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Color(0xFFFFD700),
                  size: 24,
                ),
              ),

              const SizedBox(width: 8),

              // Cart Icon
              GetBuilder<CartService>(
                builder: (cartService) {
                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DarkCartScreen(),
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.cartShopping,
                          color: Color(0xFFFFD700),
                          size: 24,
                        ),
                      ),
                      if (cartService.totalItems > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartService.totalItems}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return GetBuilder<ThemeService>(
      builder: (themeService) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: themeService.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: themeService.textColor),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Rechercher...',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Color(0xFFFFD700)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFFD700)
                    : const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
