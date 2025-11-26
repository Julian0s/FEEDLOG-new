import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/core/utils/tdee_calculator.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class ActivitySelectorWidget extends StatefulWidget {
  final Function(ActivityLevel) onConfirmed;

  const ActivitySelectorWidget({
    super.key,
    required this.onConfirmed,
  });

  @override
  State<ActivitySelectorWidget> createState() => _ActivitySelectorWidgetState();
}

class _ActivitySelectorWidgetState extends State<ActivitySelectorWidget> {
  ActivityLevel? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.activitySelectorTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
            const Gap(12),
            _buildActivityOption(
              ActivityLevel.sedentary,
              l10n.activitySedentary,
              l10n.activitySedentaryDesc,
              Icons.chair_outlined,
            ),
            const Gap(8),
            _buildActivityOption(
              ActivityLevel.light,
              l10n.activityLight,
              l10n.activityLightDesc,
              Icons.directions_walk_outlined,
            ),
            const Gap(8),
            _buildActivityOption(
              ActivityLevel.moderate,
              l10n.activityModerate,
              l10n.activityModerateDesc,
              Icons.directions_run_outlined,
            ),
            const Gap(8),
            _buildActivityOption(
              ActivityLevel.heavy,
              l10n.activityHeavy,
              l10n.activityHeavyDesc,
              Icons.fitness_center_outlined,
            ),
            const Gap(8),
            _buildActivityOption(
              ActivityLevel.athlete,
              l10n.activityAthlete,
              l10n.activityAthleteDesc,
              Icons.sports_outlined,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: _selectedLevel != null
                  ? () => widget.onConfirmed(_selectedLevel!)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonMint,
                disabledBackgroundColor: AppColors.glassMedium,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.confirmButton,
                style: AppTextStyles.button.copyWith(
                  color: _selectedLevel != null
                      ? AppColors.darkBg
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityOption(
    ActivityLevel level,
    String title,
    String description,
    IconData icon,
  ) {
    final isSelected = _selectedLevel == level;

    return GestureDetector(
      onTap: () => setState(() => _selectedLevel = level),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        backgroundColor: isSelected
            ? AppColors.neonMint.withOpacity(0.3)
            : AppColors.glassDark,
        borderColor: isSelected ? AppColors.neonMint : AppColors.glassLight,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.neonMint.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.neonMint, size: 24),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.neonMint,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
