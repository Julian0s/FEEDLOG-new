import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class LanguageSelectorWidget extends StatefulWidget {
  final Function(String) onConfirmed;

  const LanguageSelectorWidget({
    super.key,
    required this.onConfirmed,
  });

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  String? _selectedLanguageCode;

  // Language data with native names and flag emojis
  static const _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇧🇷'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'it', 'name': 'Italiano', 'flag': '🇮🇹'},
    {'code': 'zh', 'name': '中文', 'flag': '🇨🇳'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
    {'code': 'ru', 'name': 'Русский', 'flag': '🇷🇺'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
    {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
    {'code': 'hi', 'name': 'हिन्दी', 'flag': '🇮🇳'},
  ];

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
              l10n.languageSelectorTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
            const Gap(12),
            // Grid de idiomas 2 colunas
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final lang = _languages[index];
                return _buildLanguageOption(
                  lang['code']!,
                  lang['name']!,
                  lang['flag']!,
                );
              },
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: _selectedLanguageCode != null
                  ? () => widget.onConfirmed(_selectedLanguageCode!)
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
                  color: _selectedLanguageCode != null
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

  Widget _buildLanguageOption(String code, String name, String flag) {
    final isSelected = _selectedLanguageCode == code;

    return GestureDetector(
      onTap: () => setState(() => _selectedLanguageCode = code),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: isSelected
            ? AppColors.neonMint.withValues(alpha: 0.3)
            : AppColors.glassDark,
        borderColor: isSelected ? AppColors.neonMint : AppColors.glassLight,
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 20),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.body2.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.neonMint,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
