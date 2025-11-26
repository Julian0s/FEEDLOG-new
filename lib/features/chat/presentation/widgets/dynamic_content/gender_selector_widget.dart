import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/core/utils/tdee_calculator.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class GenderSelectorWidget extends StatefulWidget {
  final Function(Gender) onConfirmed;

  const GenderSelectorWidget({
    super.key,
    required this.onConfirmed,
  });

  @override
  State<GenderSelectorWidget> createState() => _GenderSelectorWidgetState();
}

class _GenderSelectorWidgetState extends State<GenderSelectorWidget> {
  Gender? _selectedGender;

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
              l10n.genderSelectorTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
            const Gap(12),
            _buildGenderOption(
              Gender.male,
              l10n.genderMale,
              Icons.male,
              AppColors.electricBlue,
            ),
            const Gap(8),
            _buildGenderOption(
              Gender.female,
              l10n.genderFemale,
              Icons.female,
              AppColors.accentCoral,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: _selectedGender != null
                  ? () => widget.onConfirmed(_selectedGender!)
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
                  color: _selectedGender != null
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

  Widget _buildGenderOption(
    Gender gender,
    String title,
    IconData icon,
    Color color,
  ) {
    final isSelected = _selectedGender == gender;

    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
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
              child: Text(
                title,
                style: AppTextStyles.body1.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
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
