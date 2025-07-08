import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/theme_controller.dart';
import '../utils/constants.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    _rotationController.forward().then((_) {
      _rotationController.reset();
    });

    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    Get.find<ThemeController>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDark = themeController.isDarkMode;

        return AnimatedBuilder(
          animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: GestureDetector(
                onTap: _toggleTheme,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              AppConstants.darkPrimaryColor,
                              AppConstants.darkSecondaryColor,
                            ]
                          : [
                              AppConstants.primaryColor,
                              AppConstants.secondaryColor,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isDark
                                    ? AppConstants.darkPrimaryColor
                                    : AppConstants.primaryColor)
                                .withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background glow effect
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      // Rotating icon
                      Transform.rotate(
                        angle: _rotationAnimation.value * 2 * 3.14159,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: FaIcon(
                            isDark
                                ? FontAwesomeIcons.sun
                                : FontAwesomeIcons.moon,
                            key: ValueKey(isDark),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),

                      // Ripple effect
                      if (_scaleAnimation.value > 1.0)
                        Container(
                          width: 56 * _scaleAnimation.value,
                          height: 56 * _scaleAnimation.value,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  (isDark
                                          ? AppConstants.darkPrimaryColor
                                          : AppConstants.primaryColor)
                                      .withValues(
                                        alpha:
                                            0.3 * (2.0 - _scaleAnimation.value),
                                      ),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              28 * _scaleAnimation.value,
                            ),
                          ),
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
  }
}

class AnimatedThemeButton extends StatefulWidget {
  const AnimatedThemeButton({super.key});

  @override
  State<AnimatedThemeButton> createState() => _AnimatedThemeButtonState();
}

class _AnimatedThemeButtonState extends State<AnimatedThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          onTap: () => themeController.toggleTheme(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 - (_animation.value * 0.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeController.isDarkMode
                          ? [
                              AppConstants.darkPrimaryColor,
                              AppConstants.darkSecondaryColor,
                            ]
                          : [
                              AppConstants.primaryColor,
                              AppConstants.secondaryColor,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (themeController.isDarkMode
                                    ? AppConstants.darkPrimaryColor
                                    : AppConstants.primaryColor)
                                .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        themeController.isDarkMode
                            ? FontAwesomeIcons.sun
                            : FontAwesomeIcons.moon,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        themeController.isDarkMode ? 'فاتح' : 'مظلم',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
