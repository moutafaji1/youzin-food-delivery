import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SimpleInstagramButton extends StatelessWidget {
  const SimpleInstagramButton({super.key});

  Future<void> _openInstagram() async {
    const instagramUrl = 'https://www.instagram.com/youzin_food?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';
    
    try {
      await launchUrl(
        Uri.parse(instagramUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // Handle error silently or show a simple message
      debugPrint('Could not open Instagram: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(
        FontAwesomeIcons.instagram,
        color: Colors.white,
        size: 20,
      ),
      onPressed: _openInstagram,
      tooltip: 'تابعنا على Instagram',
    );
  }
}
