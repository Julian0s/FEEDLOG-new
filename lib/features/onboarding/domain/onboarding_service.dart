import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nutriai/core/utils/tdee_calculator.dart';
import 'package:nutriai/core/providers/locale_provider.dart';
import 'package:nutriai/l10n/app_localizations.dart';

part 'onboarding_service.g.dart';

@riverpod
OnboardingService onboardingService(Ref ref) {
  final l10n = ref.watch(l10nProvider);
  return OnboardingService(l10n);
}

class OnboardingService {
  final AppLocalizations l10n;

  OnboardingService(this.l10n);

  /// Extract name from natural language response
  /// Example: "Oi, pode me chamar de Alexandre Feltz" -> "Alexandre Feltz"
  String? extractName(String response) {
    final trimmed = response.trim();

    // If it's just a simple name (1-4 words, no common phrases)
    if (trimmed.split(' ').length <= 4 && !_containsCommonPhrases(trimmed)) {
      return _capitalizeWords(trimmed);
    }

    // Remove common introductory phrases (Portuguese and English)
    final patterns = [
      // Portuguese - order matters, longer phrases first
      r'(?:oi|olá|ola|hey|ei|eai|e aí)[,!.\s]*',
      r'(?:quer que eu |quero que |quer que )?(?:me chame de|me chama de|me chame por|me chamam de)\s*',
      r'(?:pode me chamar de|podes me chamar de)\s*',
      r'(?:meu nome é|meu nome e|o meu nome é|o meu nome e)\s*',
      r'(?:eu sou o|eu sou a|eu sou|sou o|sou a|sou)\s*',
      r'(?:prazer|muito prazer)[,!.\s]*',
      // English
      r"(?:my name is|i'm|i am|call me|you can call me|just call me)\s*",
      r'(?:hi|hello|hey)[,!.\s]*',
    ];

    String cleaned = trimmed;
    for (final pattern in patterns) {
      cleaned = cleaned.replaceAll(RegExp(pattern, caseSensitive: false), '');
    }

    // Remove punctuation at start/end
    cleaned = cleaned.replaceAll(RegExp(r'^[,!.\s]+|[,!.\s]+$'), '').trim();

    // If we have a reasonable result (1-4 words)
    if (cleaned.isNotEmpty && cleaned.split(' ').length <= 4) {
      return _capitalizeWords(cleaned);
    }

    return null;
  }

  bool _containsCommonPhrases(String text) {
    final lower = text.toLowerCase();
    final phrases = [
      'pode me chamar', 'podes me chamar', 'quer que', 'quero que',
      'me chama', 'me chame', 'meu nome',
      'eu sou', 'sou o', 'sou a', 'prazer',
      'my name', "i'm", 'i am', 'call me', 'hi', 'hello', 'oi', 'olá'
    ];
    return phrases.any((p) => lower.contains(p));
  }

  /// Extract gender from response
  Gender? extractGender(String response) {
    final lower = response.toLowerCase();
    
    if (lower.contains('mascul') || lower.contains('homem') || lower.contains('male')) {
      return Gender.male;
    }
    if (lower.contains('femin') || lower.contains('mulher') || lower.contains('female')) {
      return Gender.female;
    }
    
    return null;
  }

  /// Extract age from response
  int? extractAge(String response) {
    // Look for numbers in the response
    final numbers = RegExp(r'\d+').allMatches(response);
    
    for (final match in numbers) {
      final number = int.tryParse(match.group(0)!);
      if (number != null && number >= 10 && number <= 120) {
        return number;
      }
    }
    
    return null;
  }

  /// Extract height in cm from response
  /// Handles: "1.75", "175", "1,75", "175cm", "1.75m"
  double? extractHeight(String response) {
    // Remove common words
    final cleaned = response.toLowerCase()
        .replaceAll(RegExp(r'(altura|height|tenho|sou|metros?|cm|centimetros?)'), '')
        .replaceAll(',', '.')
        .trim();
    
    // Try to find a decimal number
    final match = RegExp(r'(\d+\.?\d*)').firstMatch(cleaned);
    if (match != null) {
      final value = double.tryParse(match.group(0)!);
      if (value != null) {
        // If value is between 1 and 3, assume it's in meters
        if (value >= 1.0 && value <= 3.0) {
          return value * 100; // Convert to cm
        }
        // If value is reasonable for cm
        if (value >= 100 && value <= 250) {
          return value;
        }
      }
    }
    
    return null;
  }

  /// Extract weight in kg from response
  /// Handles: "85", "85kg", "85 quilos", "85.5"
  double? extractWeight(String response) {
    // Remove common words
    final cleaned = response.toLowerCase()
        .replaceAll(RegExp(r'(peso|weight|tenho|estou|kg|quilos?|kilos?)'), '')
        .replaceAll(',', '.')
        .trim();
    
    // Try to find a decimal number
    final match = RegExp(r'(\d+\.?\d*)').firstMatch(cleaned);
    if (match != null) {
      final value = double.tryParse(match.group(0)!);
      if (value != null && value >= 30 && value <= 300) {
        return value;
      }
    }
    
    return null;
  }

  /// Detect weight change command
  /// Examples: "perdi 1kg", "ganhei 2 quilos", "emagreci 500g"
  double? extractWeightChange(String response) {
    final lower = response.toLowerCase();
    
    // Check if it's a weight update command
    if (!lower.contains(RegExp(r'(perdi|perd|ganhei|ganh|emagrec|engord|peso)'))) {
      return null;
    }
    
    // Extract the number
    final match = RegExp(r'(\d+\.?\d*)\s*(kg|quilo|kilo|grama)?').firstMatch(lower);
    if (match != null) {
      var value = double.tryParse(match.group(1)!);
      if (value != null) {
        // Convert grams to kg
        if (match.group(2)?.contains('gram') == true) {
          value = value / 1000;
        }
        
        // Determine if it's loss or gain
        if (lower.contains(RegExp(r'(perdi|perd|emagrec)'))) {
          return -value; // Negative for loss
        } else {
          return value; // Positive for gain
        }
      }
    }
    
    return null;
  }

  /// Capitalize first letter of each word
  String _capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Get onboarding step order
  List<String> get onboardingSteps => [
    'welcome',
    'name',
    'gender',
    'age',
    'height',
    'weight',
    'target_weight',
    'activity',
    'goal',
    'tutorial',
    'completed',
  ];

  /// Get next onboarding step
  String? getNextStep(String currentStep) {
    final steps = onboardingSteps;
    final currentIndex = steps.indexOf(currentStep);
    if (currentIndex >= 0 && currentIndex < steps.length - 1) {
      return steps[currentIndex + 1];
    }
    return null;
  }

  /// Get AI prompt for current onboarding step
  String getPromptForStep(String step, {Map<String, dynamic>? userData}) {
    switch (step) {
      case 'welcome':
        return l10n.onboardingWelcomeMessage;

      case 'name':
        return l10n.onboardingNameConfirmation(userData?['name'] ?? '');

      case 'gender':
        final name = userData?['name'] ?? '';
        return l10n.onboardingGenderPrompt(name);

      case 'age':
        return l10n.onboardingAgePrompt;

      case 'height':
        return l10n.onboardingHeightPrompt;

      case 'weight':
        return l10n.onboardingWeightPrompt;

      case 'target_weight':
        return l10n.onboardingTargetWeightPrompt;

      case 'activity':
        return l10n.onboardingActivityPrompt;

      case 'goal':
        return l10n.onboardingGoalPrompt;

      case 'results':
        return l10n.onboardingResultsMessage(
          userData?['name'] ?? '',
          userData?['tdee'] ?? 0,
          userData?['dailyCalories'] ?? 0,
          userData?['protein'] ?? 0,
          userData?['carbs'] ?? 0,
          userData?['fat'] ?? 0,
        );

      case 'tutorial':
        return '${l10n.onboardingTutorialMessage}\n\nONBOARDING:COMPLETE';

      default:
        return '';
    }
  }
}
