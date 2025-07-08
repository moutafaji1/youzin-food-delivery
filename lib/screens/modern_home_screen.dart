import 'package:flutter/material.dart';
import '../data/modern_food_data.dart';
import '../models/food_item.dart';
import '../widgets/modern_banner.dart';
import '../widgets/simple_food_grid.dart';
import '../widgets/simple_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chip.dart';

class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'الكل';
  String searchQuery = '';
  final GlobalKey _foodSectionKey = GlobalKey();

  List<FoodItem> get filteredItems {
    List<FoodItem> items = ModernFoodData.foodItems;

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
                item.restaurant.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return items;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: const SimpleHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Modern Banner
            ModernBanner(
              onOrderNowTap: () {
                Scrollable.ensureVisible(
                  _foodSectionKey.currentContext!,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
            ),

            // Search Bar
            SearchBarWidget(
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              searchQuery: searchQuery,
              onFilterTap: () {
                _showFilterDialog();
              },
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
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        CategoryChip(
                          label: 'الكل',
                          isSelected: selectedCategory == 'الكل',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'الكل';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'برجر',
                          isSelected: selectedCategory == 'برجر',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'برجر';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'بيتزا',
                          isSelected: selectedCategory == 'بيتزا',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'بيتزا';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'مشروبات',
                          isSelected: selectedCategory == 'مشروبات',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'مشروبات';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'حلويات',
                          isSelected: selectedCategory == 'حلويات',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'حلويات';
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'سلطات',
                          isSelected: selectedCategory == 'سلطات',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'سلطات';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Food Items Section
            Container(
              key: _foodSectionKey,
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

                  // Food Items Grid
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
                      : SimpleFoodGrid(foodItems: filteredItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            'فلترة الطعام',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر الفئة:',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip('الكل'),
                  _buildFilterChip('برجر'),
                  _buildFilterChip('بيتزا'),
                  _buildFilterChip('ساندويش'),
                  _buildFilterChip('مشروبات'),
                  _buildFilterChip('حلويات'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'إغلاق',
                style: TextStyle(color: Color(0xFFFFD700)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                )
              : null,
          color: isSelected ? null : const Color(0xFF333333),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF555555),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
