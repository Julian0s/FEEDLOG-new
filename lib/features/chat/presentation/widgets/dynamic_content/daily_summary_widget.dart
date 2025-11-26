import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class DailySummaryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const DailySummaryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final int calories = data['calories'] ?? 0;
    final int protein = data['protein'] ?? 0;
    final int carbs = data['carbs'] ?? 0;
    final int fat = data['fat'] ?? 0;

    return GlassContainer(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(20),
      backgroundColor: AppColors.deepOcean.withOpacity(0.6),
      borderColor: AppColors.neonMint.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dailySummaryTitle,
            style: AppTextStyles.h2.copyWith(fontSize: 18),
          ).animate().fadeIn().slideX(),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroItem(l10n.dailySummaryCalories, '$calories', l10n.dailySummaryKcal, AppColors.neonMint),
              _buildMacroItem(l10n.dailySummaryProtein, '${protein}g', l10n.dailySummaryLeft, AppColors.proteinRed),
            ],
          ).animate().fadeIn(delay: 200.ms),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroItem(l10n.dailySummaryCarbs, '${carbs}g', l10n.dailySummaryLeft, AppColors.carbAmber),
              _buildMacroItem(l10n.dailySummaryFat, '${fat}g', l10n.dailySummaryLeft, AppColors.fatPurple),
            ],
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildMacroItem(
      String label, String value, String subLabel, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: color),
            ),
            const Gap(4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    subLabel,
                    style: AppTextStyles.caption.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
