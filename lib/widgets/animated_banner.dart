import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../utils/constants.dart';

class AnimatedBanner extends StatefulWidget {
  const AnimatedBanner({super.key});

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _floatingController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut),
    );

    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDarkMode;

    return AnimatedBuilder(
      animation: Listenable.merge([_gradientAnimation, _floatingAnimation]),
      builder: (context, child) {
        return Container(
          height: 200,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                _gradientAnimation.value * 0.5,
                _gradientAnimation.value,
                1.0,
              ],
              colors: isDark
                  ? [
                      AppConstants.darkPrimaryColor,
                      AppConstants.darkSecondaryColor,
                      AppConstants.darkAccentColor,
                      AppConstants.darkGoldColor,
                    ]
                  : [
                      AppConstants.primaryColor,
                      AppConstants.secondaryColor,
                      AppConstants.accentColor,
                      AppConstants.goldColor,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color:
                    (isDark
                            ? AppConstants.darkPrimaryColor
                            : AppConstants.primaryColor)
                        .withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Floating particles effect
              ...List.generate(6, (index) {
                return Positioned(
                  left: 20.0 + (index * 50.0),
                  top: 30.0 + (index % 2 * 40.0) + _floatingAnimation.value,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),

              // Main content
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated welcome text
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, _floatingAnimation.value * 0.5),
                          child: const FaIcon(
                            FontAwesomeIcons.utensils,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'مرحباً بك في YouZine FOOD',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                              TypewriterAnimatedText(
                                'أفضل تطبيق توصيل طعام',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                            repeatForever: true,
                            pause: const Duration(seconds: 2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Subtitle with fade animation
                    AnimatedOpacity(
                      opacity: 0.5 + (_gradientAnimation.value * 0.5),
                      duration: const Duration(milliseconds: 300),
                      child: const Text(
                        'اطلب ألذ الوجبات واستمتع بالطعم الرائع',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Features row with icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeatureIcon(
                          FontAwesomeIcons.clock,
                          'توصيل سريع',
                          _floatingAnimation.value * 0.3,
                        ),
                        _buildFeatureIcon(
                          FontAwesomeIcons.star,
                          'جودة عالية',
                          -_floatingAnimation.value * 0.3,
                        ),
                        _buildFeatureIcon(
                          FontAwesomeIcons.whatsapp,
                          'طلب سهل',
                          _floatingAnimation.value * 0.2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Shimmer effect overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusLarge,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(
                        -1.0 + _gradientAnimation.value * 2,
                        0.0,
                      ),
                      end: Alignment(1.0 + _gradientAnimation.value * 2, 0.0),
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label, double offset) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
