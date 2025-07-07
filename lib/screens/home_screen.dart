import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/cart_controller.dart';

import '../l10n/app_strings.dart';

import '../data/food_data.dart';
import '../models/food_item.dart';
import '../widgets/dark_food_card.dart';
import '../widgets/category_chip.dart';

import '../widgets/simple_instagram_button.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'الكل';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _mostPopularScrollController = ScrollController();
  int _currentPopularIndex = 0;
  List<FoodItem> foodItems = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    foodItems = FoodData.getFoodItems();
    categories = FoodData.getCategories();

    // Add listener to update dots indicator
    _mostPopularScrollController.addListener(() {
      final offset = _mostPopularScrollController.offset;
      final itemWidth = 350.0 + 16.0; // item width + separator
      final newIndex = (offset / itemWidth).round();
      if (newIndex != _currentPopularIndex &&
          newIndex >= 0 &&
          newIndex < mostPopularItems.length) {
        setState(() {
          _currentPopularIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mostPopularScrollController.dispose();
    super.dispose();
  }

  List<FoodItem> get filteredItems {
    List<FoodItem> items = foodItems;

    // Filter by category
    if (selectedCategory != 'الكل') {
      items = items.where((item) => item.category == selectedCategory).toList();
    }

    // Filter by search query
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

  List<FoodItem> get mostPopularItems {
    // Get items with highest rating or most ordered (simulated)
    List<FoodItem> popular = [...foodItems];
    popular.shuffle(); // Simulate popularity
    return popular.take(6).toList();
  }

  String getTranslatedCategory(String category, BuildContext context) {
    switch (category) {
      case 'الكل':
        return AppStrings.get(context, 'all');
      case 'برجر':
        return AppStrings.get(context, 'burgers');
      case 'بيتزا':
        return AppStrings.get(context, 'pizza');
      case 'مشروبات':
        return AppStrings.get(context, 'drinks');
      case 'حلويات':
        return AppStrings.get(context, 'desserts');
      case 'سلطات':
        return AppStrings.get(context, 'salads');
      case 'ساندويتش':
        return AppStrings.get(context, 'sandwiches');
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final isVerySmall = availableWidth < 200;

            return Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.utensils,
                  color: const Color(0xFFFFD700),
                  size: isVerySmall ? 20 : 24,
                ),
                SizedBox(width: isVerySmall ? 6 : 8),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: isVerySmall ? 'YouZin' : 'YouZin ',
                          style: TextStyle(
                            color: const Color(0xFFFFD700),
                            fontWeight: FontWeight.bold,
                            fontSize: isVerySmall ? 16 : 18,
                          ),
                        ),
                        if (!isVerySmall)
                          const TextSpan(
                            text: 'Food',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          // Location Info - Responsive
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final isVerySmall = availableWidth < 150;
                final isSmall = availableWidth < 200;

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isVerySmall ? 6 : (isSmall ? 8 : 12),
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFD700),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: const Color(0xFFFFD700),
                        size: isVerySmall ? 12 : 14,
                      ),
                      SizedBox(width: isVerySmall ? 2 : 3),
                      Flexible(
                        child: Text(
                          isVerySmall
                              ? 'MHAMID'
                              : (isSmall
                                    ? 'MHAMID - Marrakech'
                                    : 'MHAMID - Marrakech, Maroc'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isVerySmall ? 9 : (isSmall ? 10 : 12),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 4),

          // Instagram Button (simple)
          const SimpleInstagramButton(),

          // Contact Button
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.phone,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              // Contact functionality
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1A1A1A),
                  title: Text(
                    AppStrings.get(context, 'contact_us'),
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'رقم الهاتف: 0777149406',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Instagram: @youzine_food',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppStrings.get(context, 'close'),
                        style: const TextStyle(color: Color(0xFFFFD700)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Cart Button
          GetBuilder<CartController>(
            builder: (cart) {
              return Stack(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.cartShopping),
                    onPressed: () {
                      Get.to(() => const CartScreen());
                    },
                  ),
                  if (cart.itemCount > 0)
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
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar Section
            Container(
              width: double.infinity,
              color: const Color(0xFF0F0F0F),
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFF333333)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: AppStrings.get(context, 'search_hint'),
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFFFD700),
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.white54,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ),

            // Most Popular Section
            if (searchQuery.isEmpty && selectedCategory == 'الكل')
              Container(
                width: double.infinity,
                color: const Color(0xFF0F0F0F),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.fire,
                          color: Color(0xFFFFD700),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.get(context, 'most_popular'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
                        SizedBox(
                          height: 280,
                          child: ListView.separated(
                            controller: _mostPopularScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: mostPopularItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 350,
                                child: DarkFoodCard(
                                  foodItem: mostPopularItems[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // Dots Indicator
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        mostPopularItems.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPopularIndex == index ? 12 : 8,
                          height: _currentPopularIndex == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPopularIndex == index
                                ? const Color(0xFFFFD700)
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Categories Section
            Container(
              width: double.infinity,
              color: const Color(0xFF0F0F0F),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'الفئات',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CategoryChip(
                            label: getTranslatedCategory(
                              categories[index],
                              context,
                            ),
                            isSelected: selectedCategory == categories[index],
                            onTap: () {
                              setState(() {
                                selectedCategory = categories[index];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Food Items Section
            Container(
              width: double.infinity,
              color: const Color(0xFF0F0F0F),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCategory == 'الكل'
                        ? 'جميع الأطباق'
                        : selectedCategory,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Food Items List
                  filteredItems.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Text(
                              'لا توجد عناصر في هذه الفئة',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredItems.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 24),
                          itemBuilder: (context, index) {
                            return DarkFoodCard(foodItem: filteredItems[index]);
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
