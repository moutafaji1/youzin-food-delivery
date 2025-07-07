import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class InstagramButton extends StatefulWidget {
  const InstagramButton({super.key});

  @override
  State<InstagramButton> createState() => _InstagramButtonState();
}

class _InstagramButtonState extends State<InstagramButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _openInstagram() async {
    const instagramUrl =
        'https://www.instagram.com/youzin_food?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';
    const instagramAppUrl = 'instagram://user?username=youzin_food';

    try {
      // Try to open Instagram app first
      if (await canLaunchUrl(Uri.parse(instagramAppUrl))) {
        await launchUrl(Uri.parse(instagramAppUrl));
      } else {
        // Fallback to web browser
        await launchUrl(
          Uri.parse(instagramUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لا يمكن فتح الإنستغرام'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        // final isDark = themeController.isDarkMode;

        return AnimatedBuilder(
          animation: Listenable.merge([_pulseAnimation, _shimmerAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: GestureDetector(
                onTap: _openInstagram,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF833AB4), // Instagram purple
                        Color(0xFFE1306C), // Instagram pink
                        Color(0xFFFD1D1D), // Instagram red
                        Color(0xFFF77737), // Instagram orange
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE1306C).withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Shimmer effect
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(_shimmerAnimation.value - 1, 0),
                              end: Alignment(_shimmerAnimation.value, 0),
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Instagram icon
                      const FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                        size: 28,
                      ),

                      // Pulse ring
                      Container(
                        width: 60 + ((_pulseAnimation.value - 1) * 20),
                        height: 60 + ((_pulseAnimation.value - 1) * 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFE1306C).withValues(
                              alpha: 0.3 * (2.0 - _pulseAnimation.value),
                            ),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(
                            20 + ((_pulseAnimation.value - 1) * 10),
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

class InstagramFloatingButton extends StatefulWidget {
  const InstagramFloatingButton({super.key});

  @override
  State<InstagramFloatingButton> createState() =>
      _InstagramFloatingButtonState();
}

class _InstagramFloatingButtonState extends State<InstagramFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openInstagram() async {
    const instagramUrl =
        'https://www.instagram.com/youzin_food?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';

    try {
      await launchUrl(
        Uri.parse(instagramUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لا يمكن فتح الإنستغرام'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _controller.forward(),
              onTapUp: (_) {
                _controller.reverse();
                _openInstagram();
              },
              onTapCancel: () => _controller.reverse(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF833AB4),
                      Color(0xFFE1306C),
                      Color(0xFFFD1D1D),
                      Color(0xFFF77737),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE1306C).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'تابعنا',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
