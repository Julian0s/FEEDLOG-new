import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepOcean,
      primaryColor: AppColors.neonMint,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonMint,
        secondary: AppColors.electricBlue,
        surface: AppColors.deepOcean, // Using deepOcean as surface for now
        error: AppColors.proteinRed,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body1,
        bodySmall: AppTextStyles.caption,
      ),
      // Add more theme customizations here as needed
    );
  }
}
