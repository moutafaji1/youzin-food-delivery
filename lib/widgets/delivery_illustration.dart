import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryIllustration extends StatefulWidget {
  const DeliveryIllustration({super.key});

  @override
  State<DeliveryIllustration> createState() => _DeliveryIllustrationState();
}

class _DeliveryIllustrationState extends State<DeliveryIllustration>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle
          AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFD700).withValues(alpha: 0.1),
                        const Color(0xFFFFD700).withValues(alpha: 0.3),
                        const Color(0xFFFFD700).withValues(alpha: 0.1),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Main Illustration
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Scooter
                      const Positioned(
                        bottom: 30,
                        child: FaIcon(
                          FontAwesomeIcons.motorcycle,
                          size: 40,
                          color: Color(0xFF4CAF50),
                        ),
                      ),

                      // Delivery Person
                      Positioned(
                        top: 25,
                        child: Column(
                          children: [
                            // Head
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(0xFFFFDBB5),
                              child: FaIcon(
                                FontAwesomeIcons.faceSmile,
                                size: 12,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Body
                            Container(
                              width: 25,
                              height: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Delivery Bag
                      Positioned(
                        right: 20,
                        top: 35,
                        child: Container(
                          width: 20,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5722),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.utensils,
                              size: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Speed Lines
                      Positioned(
                        left: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 15,
                              height: 2,
                              color: const Color(
                                0xFFFFD700,
                              ).withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 20,
                              height: 2,
                              color: const Color(
                                0xFFFFD700,
                              ).withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 12,
                              height: 2,
                              color: const Color(
                                0xFFFFD700,
                              ).withValues(alpha: 0.6),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Brand Text
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                Text(
                  'YouZin FOOD',
                  style: TextStyle(
                    color: const Color(0xFFFFD700),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'توصيل سريع وآمن',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
