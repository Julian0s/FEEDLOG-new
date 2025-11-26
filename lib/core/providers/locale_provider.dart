import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../l10n/app_localizations.dart';
import '../services/firestore_user_service.dart';

part 'locale_provider.g.dart';

/// Supported language codes in the app
const supportedLocaleCodes = [
  'en', 'pt', 'es', 'fr', 'de', 'it',
  'zh', 'ja', 'ru', 'ar', 'ko', 'hi'
];

/// Language names for display
const languageNames = {
  'en': 'English',
  'pt': 'Português',
  'es': 'Español',
  'fr': 'Français',
  'de': 'Deutsch',
  'it': 'Italiano',
  'zh': '中文',
  'ja': '日本語',
  'ru': 'Русский',
  'ar': 'العربية',
  'ko': '한국어',
  'hi': 'हिन्दी',
};

/// Check if a language code is supported
bool isLocaleSupported(String code) => supportedLocaleCodes.contains(code);

/// Get the device's preferred locale, falling back to English if not supported
Locale getDeviceLocale() {
  final deviceLocale = PlatformDispatcher.instance.locale;
  if (isLocaleSupported(deviceLocale.languageCode)) {
    return Locale(deviceLocale.languageCode);
  }
  return const Locale('en');
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Start with device locale (or English if not supported)
    return getDeviceLocale();
  }

  /// Set a new locale
  void setLocale(Locale locale) {
    if (isLocaleSupported(locale.languageCode)) {
      state = locale;
    }
  }

  /// Set locale from language code string
  void setLocaleFromCode(String languageCode) {
    if (isLocaleSupported(languageCode)) {
      state = Locale(languageCode);
    }
  }

  /// Load locale from Firestore for a logged-in user
  Future<void> loadFromFirestore(String userId) async {
    final firestoreService = ref.read(firestoreUserServiceProvider);
    final savedLanguage = await firestoreService.getLanguage(userId);
    if (savedLanguage != null && isLocaleSupported(savedLanguage)) {
      state = Locale(savedLanguage);
    }
  }

  /// Save locale to Firestore for a logged-in user
  Future<void> saveToFirestore(String userId, String languageCode) async {
    if (!isLocaleSupported(languageCode)) return;

    final firestoreService = ref.read(firestoreUserServiceProvider);
    await firestoreService.updateLanguage(userId, languageCode);
    state = Locale(languageCode);
  }
}

/// Provider for AppLocalizations based on current locale
/// This allows using translations without BuildContext
@riverpod
AppLocalizations l10n(Ref ref) {
  final locale = ref.watch(localeProvider);
  return lookupAppLocalizations(locale);
}
