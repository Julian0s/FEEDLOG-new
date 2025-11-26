import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color neonMint = Color(0xFF00FF9D);
  static const Color deepOcean = Color(0xFF0A1929);
  static const Color darkBg = Color(0xFF0A1929); // Same as deepOcean
  static const Color electricBlue = Color(0xFF00D4FF);

  // Secondary / Functional
  static const Color proteinRed = Color(0xFFFF4D4D);
  static const Color carbAmber = Color(0xFFFFC107);
  static const Color fatPurple = Color(0xFF9D4EDD);
  static const Color accentCoral = Color(0xFFFF6B6B); // Added for goal selector

  // Glass Surface
  static const Color glassLight = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color glassMedium = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color glassDark = Color.fromRGBO(0, 0, 0, 0.3); // Added for dark glass effect
  static const Color glassHighlight = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.5);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0BEC5); // Grey 400 equivalent
}
