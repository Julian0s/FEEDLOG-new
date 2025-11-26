import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/core/utils/tdee_calculator.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class GoalSelectorWidget extends StatefulWidget {
  final Function(WeightGoal) onConfirmed;

  const GoalSelectorWidget({
    super.key,
    required this.onConfirmed,
  });

  @override
  State<GoalSelectorWidget> createState() => _GoalSelectorWidgetState();
}

class _GoalSelectorWidgetState extends State<GoalSelectorWidget> {
  WeightGoal? _selectedGoal;

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
              l10n.goalSelectorTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
            const Gap(12),
            _buildGoalOption(
              WeightGoal.lose,
              l10n.goalLose,
              l10n.goalLoseDesc,
              Icons.trending_down,
              AppColors.accentCoral,
            ),
            const Gap(8),
            _buildGoalOption(
              WeightGoal.maintain,
              l10n.goalMaintain,
              l10n.goalMaintainDesc,
              Icons.horizontal_rule,
              AppColors.electricBlue,
            ),
            const Gap(8),
            _buildGoalOption(
              WeightGoal.gain,
              l10n.goalGain,
              l10n.goalGainDesc,
              Icons.trending_up,
              AppColors.neonMint,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: _selectedGoal != null
                  ? () => widget.onConfirmed(_selectedGoal!)
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
                  color: _selectedGoal != null
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

  Widget _buildGoalOption(
    WeightGoal goal,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    final isSelected = _selectedGoal == goal;

    return GestureDetector(
      onTap: () => setState(() => _selectedGoal = goal),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        backgroundColor: isSelected
            ? color.withOpacity(0.3)
            : AppColors.glassDark,
        borderColor: isSelected ? color : AppColors.glassLight,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
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
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
