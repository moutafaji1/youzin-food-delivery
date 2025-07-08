import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearchChanged;
  final String searchQuery;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    super.key,
    required this.onSearchChanged,
    required this.searchQuery,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF333333), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white60,
              size: 16,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'ابحث عن طعامك المفضل...',
                hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const FaIcon(
                FontAwesomeIcons.sliders,
                color: Colors.black,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
