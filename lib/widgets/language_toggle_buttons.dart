import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';

class LanguageToggleButtons extends StatefulWidget {
  const LanguageToggleButtons({super.key});

  @override
  State<LanguageToggleButtons> createState() => _LanguageToggleButtonsState();
}

class _LanguageToggleButtonsState extends State<LanguageToggleButtons>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (languageController) {
        return GetBuilder<ThemeController>(
          builder: (themeController) {
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFFFD700,
                            ).withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLanguageButton(
                            context,
                            'AR',
                            FontAwesomeIcons.language,
                            languageController.isArabic,
                            () {
                              languageController.setArabic();
                              _onLanguageChanged();
                            },
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: const Color(
                              0xFFFFD700,
                            ).withValues(alpha: 0.3),
                          ),
                          _buildLanguageButton(
                            context,
                            'FR',
                            FontAwesomeIcons.globe,
                            languageController.isFrench,
                            () {
                              languageController.setFrench();
                              _onLanguageChanged();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    String text,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFD700).withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 14,
              color: isSelected
                  ? const Color(0xFFFFD700)
                  : Colors.white.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompactLanguageToggle extends StatelessWidget {
  const CompactLanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (languageController) {
        return GestureDetector(
          onTap: () {
            languageController.toggleLanguage();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.language,
                  size: 12,
                  color: const Color(0xFFFFD700),
                ),
                const SizedBox(width: 4),
                Text(
                  languageController.isArabic ? 'AR' : 'FR',
                  style: const TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
