import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/ai_service.dart';
import '../../../../core/services/firestore_user_service.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../features/auth/domain/auth_service.dart';
import '../../../../features/onboarding/domain/onboarding_service.dart';
import '../../../../core/utils/tdee_calculator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/chat_message.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  bool _isOnboarding = false;
  String _currentStep = 'welcome';
  Map<String, dynamic> _tempUserData = {};

  /// Get current localization instance
  AppLocalizations get _l10n => ref.read(l10nProvider);

  @override
  List<ChatMessage> build() {
    // Check onboarding status on initialization
    _checkOnboardingStatus();
    
    // Start with empty state, content will be added by _checkOnboardingStatus
    return [];
  }

  Future<void> _checkOnboardingStatus() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    try {
      final firestoreService = ref.read(firestoreUserServiceProvider);
      final userData = await firestoreService.getUserData(user.uid);

      // Load user's preferred language from Firestore
      await ref.read(localeProvider.notifier).loadFromFirestore(user.uid);

      // Load user's profile photo
      await ref.read(userProfilePhotoProvider.notifier).loadFromFirestore(user.uid);

      if (userData == null || userData['onboardingCompleted'] != true) {
        _startOnboarding(userData);
      } else {
        _isOnboarding = false;
        state = [
          ChatMessage(
            id: const Uuid().v4(),
            content: _l10n.chatWelcomeBack,
            sender: MessageSender.ai,
            timestamp: DateTime.now(),
          ),
        ];
      }
    } catch (e) {
      // Fallback for permission errors or network issues
      print("Error checking onboarding status: $e");
      // Assume new user and start onboarding
      _startOnboarding(null);
    }
  }

  void _startOnboarding(Map<String, dynamic>? userData) async {
    _isOnboarding = true;

    final user = ref.read(currentUserProvider);

    // Verificar se o usuário já selecionou o idioma
    final languageSelected = userData?['languageSelected'] == true;

    if (user != null && !languageSelected) {
      _currentStep = 'language_selection';
      await _addAiMessage(_l10n.onboardingLanguagePrompt);
      _addWidgetMessage('language_selector', {});
      return;
    }

    _currentStep = userData?['onboardingStep'] ?? 'welcome';

    // Load existing profile data if any
    if (userData != null) {
      if (user != null) {
         try {
            final firestoreService = ref.read(firestoreUserServiceProvider);
            final profile = await firestoreService.getUserProfile(user.uid);
            final weight = await firestoreService.getWeightTracking(user.uid);
            if (profile != null) {
              _tempUserData['name'] = profile.name;
              _tempUserData['age'] = profile.age;
              _tempUserData['height'] = profile.height;
              _tempUserData['gender'] = profile.gender;
            }
            if (weight != null) {
              _tempUserData['currentWeight'] = weight.currentWeight;
            }
         } catch (e) {
           print("Error loading profile data: $e");
         }
      }
    }

    // Send initial onboarding message
    final onboardingService = ref.read(onboardingServiceProvider);
    final prompt = onboardingService.getPromptForStep(_currentStep, userData: _tempUserData);

    // Process WIDGET markers in the prompt
    if (prompt.contains('WIDGET:profile_photo_selector')) {
      // Remove the marker and add the message
      final cleanPrompt = prompt.replaceAll('WIDGET:profile_photo_selector', '').trim();
      await _addAiMessage(cleanPrompt);

      // Add the widget with correct gender
      final isMale = _tempUserData['gender'] == Gender.male;
      _addWidgetMessage('profile_photo_selector', {'isMale': isMale});
    } else {
      _addAiMessage(prompt);
    }
  }

  void sendMessage(String text) async {
    // Add user message
    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    state = [...state, userMessage];

    // Check for logout command
    if (_isLogoutCommand(text)) {
      await _handleLogout();
      return;
    }

    // Check for language list request (before language change to handle "quais idiomas" type questions)
    if (_detectLanguageListRequest(text)) {
      await _handleLanguageListRequest();
      return;
    }

    // Check for language change request
    final requestedLanguage = _detectLanguageChangeRequest(text);
    if (requestedLanguage != null) {
      await _handleLanguageChange(requestedLanguage);
      return;
    }

    // Check for photo change request
    if (_detectPhotoChangeRequest(text)) {
      await _handlePhotoChangeRequest();
      return;
    }

    if (_isOnboarding) {
      await _handleOnboardingMessage(text);
    } else {
      await _handleNormalMessage(text);
    }
  }

  /// Detect if user wants to change their profile photo
  bool _detectPhotoChangeRequest(String text) {
    final lower = text.toLowerCase().trim();

    final patterns = [
      // Portuguese
      'trocar minha foto', 'mudar minha foto', 'alterar minha foto',
      'trocar foto', 'mudar foto', 'alterar foto',
      'trocar meu avatar', 'mudar meu avatar', 'alterar meu avatar',
      'trocar avatar', 'mudar avatar', 'alterar avatar',
      'quero outra foto', 'quero outro avatar',
      'atualizar foto', 'atualizar avatar',
      // English
      'change my photo', 'change my picture', 'change my avatar',
      'update my photo', 'update my picture', 'update my avatar',
      'new photo', 'new avatar', 'new picture',
      'switch my photo', 'switch my avatar',
      // Spanish
      'cambiar mi foto', 'cambiar mi avatar', 'cambiar foto',
      // French
      'changer ma photo', 'changer mon avatar',
      // German
      'mein foto ändern', 'mein avatar ändern',
    ];

    for (final pattern in patterns) {
      if (lower.contains(pattern)) {
        return true;
      }
    }

    return false;
  }

  Future<void> _handlePhotoChangeRequest() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final firestoreService = ref.read(firestoreUserServiceProvider);

    // Get user's gender to show correct avatars
    final profile = await firestoreService.getUserProfile(user.uid);
    final isMale = profile?.gender == Gender.male;

    await _addAiMessage(_l10n.profilePhotoChangeRequest);
    _addWidgetMessage('profile_photo_selector', {
      'isMale': isMale,
    });
  }

  bool _isLogoutCommand(String text) {
    final lower = text.toLowerCase().trim();
    return lower == 'logout' ||
        lower == 'sair' ||
        lower == 'deslogar' ||
        lower.contains('quero sair') ||
        lower.contains('quero fazer logout') ||
        lower.contains('fazer logout') ||
        lower.contains('deslogar') ||
        lower.contains('sign out');
  }

  /// Detect if user is requesting a language change
  /// Returns the detected language code or null
  String? _detectLanguageChangeRequest(String text) {
    final lower = text.toLowerCase().trim();

    // Language change patterns for multiple languages
    final patterns = {
      // English patterns
      'en': [
        'change to english', 'switch to english', 'english please',
        'in english', 'speak english', 'use english',
        'mudar para inglês', 'trocar para inglês', 'em inglês',
        'cambiar a inglés', 'en inglés',
        'changer en anglais', 'en anglais',
      ],
      // Portuguese patterns
      'pt': [
        'change to portuguese', 'switch to portuguese', 'portuguese please',
        'in portuguese', 'speak portuguese', 'use portuguese',
        'mudar para português', 'trocar para português', 'em português',
        'falar português', 'usar português', 'português por favor',
        'cambiar a portugués', 'en portugués',
      ],
      // Spanish patterns
      'es': [
        'change to spanish', 'switch to spanish', 'spanish please',
        'in spanish', 'speak spanish', 'use spanish',
        'mudar para espanhol', 'trocar para espanhol', 'em espanhol',
        'cambiar a español', 'en español', 'hablar español',
        'usar español', 'español por favor',
      ],
      // French patterns
      'fr': [
        'change to french', 'switch to french', 'french please',
        'in french', 'speak french', 'use french',
        'mudar para francês', 'em francês',
        'changer en français', 'en français', 'parler français',
        'cambiar a francés',
      ],
      // German patterns
      'de': [
        'change to german', 'switch to german', 'german please',
        'in german', 'speak german', 'use german',
        'mudar para alemão', 'em alemão',
        'auf deutsch', 'deutsch bitte', 'deutsch sprechen',
      ],
      // Italian patterns
      'it': [
        'change to italian', 'switch to italian', 'italian please',
        'in italian', 'speak italian', 'use italian',
        'mudar para italiano', 'em italiano',
        'cambiare in italiano', 'in italiano', 'parlare italiano',
      ],
      // Chinese patterns
      'zh': [
        'change to chinese', 'switch to chinese', 'chinese please',
        'in chinese', 'speak chinese', 'use chinese',
        'mudar para chinês', 'em chinês',
        '用中文', '换成中文', '说中文',
      ],
      // Japanese patterns
      'ja': [
        'change to japanese', 'switch to japanese', 'japanese please',
        'in japanese', 'speak japanese', 'use japanese',
        'mudar para japonês', 'em japonês',
        '日本語で', '日本語に変更',
      ],
      // Russian patterns
      'ru': [
        'change to russian', 'switch to russian', 'russian please',
        'in russian', 'speak russian', 'use russian',
        'mudar para russo', 'em russo',
        'на русском', 'по-русски',
      ],
      // Arabic patterns
      'ar': [
        'change to arabic', 'switch to arabic', 'arabic please',
        'in arabic', 'speak arabic', 'use arabic',
        'mudar para árabe', 'em árabe',
        'بالعربية', 'العربية',
      ],
      // Korean patterns
      'ko': [
        'change to korean', 'switch to korean', 'korean please',
        'in korean', 'speak korean', 'use korean',
        'mudar para coreano', 'em coreano',
        '한국어로', '한국어로 변경',
      ],
      // Hindi patterns
      'hi': [
        'change to hindi', 'switch to hindi', 'hindi please',
        'in hindi', 'speak hindi', 'use hindi',
        'mudar para hindi', 'em hindi',
        'हिंदी में', 'हिंदी में बदलें',
      ],
    };

    for (final entry in patterns.entries) {
      for (final pattern in entry.value) {
        if (lower.contains(pattern)) {
          return entry.key;
        }
      }
    }

    return null;
  }

  Future<void> _handleLanguageChange(String languageCode) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    // Check if language is supported
    if (!isLocaleSupported(languageCode)) {
      final availableLanguages = languageNames.entries
          .map((e) => '${e.value} (${e.key})')
          .join(', ');
      await _addAiMessage(_l10n.languageNotSupported(availableLanguages));
      return;
    }

    // Save to Firestore and update local state
    await ref.read(localeProvider.notifier).saveToFirestore(user.uid, languageCode);

    // Refresh l10n reference after locale change
    final newL10n = ref.read(l10nProvider);
    final languageName = languageNames[languageCode] ?? languageCode;
    await _addAiMessage(newL10n.languageChanged(languageName));
  }

  /// Detect if user is asking about available languages
  bool _detectLanguageListRequest(String text) {
    final lower = text.toLowerCase().trim();

    // Patterns for asking about available languages in multiple languages
    final patterns = [
      // Portuguese
      'quais idiomas', 'idiomas disponíveis', 'listar idiomas', 'que línguas',
      'quais línguas', 'mudar idioma', 'trocar idioma', 'alterar idioma',
      'idiomas suportados', 'ver idiomas',
      // English
      'which languages', 'available languages', 'list languages', 'what languages',
      'supported languages', 'change language', 'switch language', 'show languages',
      'language options', 'language settings',
      // Spanish
      'qué idiomas', 'idiomas disponibles', 'listar idiomas', 'cambiar idioma',
      'idiomas soportados', 'opciones de idioma',
      // French
      'quelles langues', 'langues disponibles', 'changer de langue', 'changer langue',
      'langues supportées', 'options de langue',
      // German
      'welche sprachen', 'verfügbare sprachen', 'sprache ändern', 'sprache wechseln',
      'sprachoptionen', 'unterstützte sprachen',
      // Italian
      'quali lingue', 'lingue disponibili', 'cambiare lingua', 'opzioni lingua',
      // Chinese
      '有哪些语言', '可用语言', '支持的语言', '更改语言', '语言选项',
      // Japanese
      'どの言語', '利用可能な言語', '言語を変更', '言語オプション',
      // Russian
      'какие языки', 'доступные языки', 'изменить язык', 'языковые опции',
      // Arabic
      'ما هي اللغات', 'اللغات المتاحة', 'تغيير اللغة',
      // Korean
      '어떤 언어', '사용 가능한 언어', '언어 변경', '언어 옵션',
      // Hindi
      'कौन सी भाषाएं', 'उपलब्ध भाषाएं', 'भाषा बदलें',
    ];

    for (final pattern in patterns) {
      if (lower.contains(pattern)) {
        return true;
      }
    }

    return false;
  }

  Future<void> _handleLanguageListRequest() async {
    await _addAiMessage(_l10n.languageSelectorPrompt);
    _addWidgetMessage('language_selector', {});
  }

  Future<void> _handleLogout() async {
    await _addAiMessage(_l10n.chatLogoutConfirmation);

    // Wait a bit for the message to be displayed
    await Future.delayed(const Duration(seconds: 1));

    // Sign out
    final authService = ref.read(authServiceProvider);
    await authService.signOut();

    // Clear chat state
    state = [];
  }

  Future<void> _handleOnboardingMessage(String text) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final onboardingService = ref.read(onboardingServiceProvider);
    final firestoreService = ref.read(firestoreUserServiceProvider);

    // Extract data based on current step
    switch (_currentStep) {
      case 'welcome':
        // Use AI to extract name - handles any phrasing, typos, or errors
        String? name;
        final aiService = ref.read(aiServiceProvider);

        try {
          final prompt = '''Extract ONLY the user's name or nickname from this phrase.
The user is answering the question "What would you like to be called?"
User's phrase: "$text"

Instructions:
- Return ONLY the name/nickname, no punctuation
- Ignore typos, grammar errors, or any language mistakes
- The user may write in any language (Portuguese, English, Spanish, etc.)
- Common patterns: "call me X", "I'm X", "my name is X", "me chame de X", "sou X", etc.
- If it's just a simple name, return it
- If you cannot identify a name, return exactly: NULL

Response:''';

          final aiResponse = await aiService.generateResponse(prompt, []);
          final cleanedResponse = aiResponse.trim()
              .replaceAll(RegExp(r'^["' "'" r']|["' "'" r']$'), '') // Remove quotes
              .replaceAll(RegExp(r'[^\w\s\u00C0-\u017F-]'), '') // Keep letters, accents, spaces, hyphens
              .trim();

          if (cleanedResponse.toUpperCase() != 'NULL' &&
              cleanedResponse.isNotEmpty &&
              cleanedResponse.length <= 50) {
            name = cleanedResponse;
          }
        } catch (e) {
          print("AI extraction failed: $e");
          // Fallback to regex extraction
          name = onboardingService.extractName(text);
        }

        if (name != null) {
          _tempUserData['name'] = name;
          _currentStep = 'gender';
        } else {
          await _addAiMessage(_l10n.chatNameError);
          return;
        }
        break;
      case 'name':
        // This case is no longer used, kept for compatibility
        _currentStep = 'gender';
        break;
      case 'gender':
        // Handled by widget, users shouldn't type here
        await _addAiMessage(_l10n.chatSelectOptionAbove);
        return;
      case 'profile_photo':
        // Handled by widget, users shouldn't type here
        await _addAiMessage(_l10n.chatSelectOptionAbove);
        return;
      case 'age':
        final age = onboardingService.extractAge(text);
        if (age != null) {
          _tempUserData['age'] = age;
          await _addAiMessage(_l10n.chatAgeConfirmation(age));
          _currentStep = 'height';
        } else {
          await _addAiMessage(_l10n.chatAgeError);
          return;
        }
        break;
      case 'height':
        final height = onboardingService.extractHeight(text);
        if (height != null) {
          _tempUserData['height'] = height;
          await _addAiMessage(_l10n.chatHeightConfirmation((height / 100).toStringAsFixed(2)));
          _currentStep = 'weight';
        } else {
          await _addAiMessage(_l10n.chatHeightError);
          return;
        }
        break;
      case 'weight':
        final weight = onboardingService.extractWeight(text);
        if (weight != null) {
          _tempUserData['currentWeight'] = weight;
          _tempUserData['initialWeight'] = weight;
          await _addAiMessage(_l10n.chatWeightConfirmation(weight));
          _currentStep = 'target_weight';
        } else {
          await _addAiMessage(_l10n.chatWeightError);
          return;
        }
        break;
      case 'target_weight':
        final target = onboardingService.extractWeight(text);
        if (target != null) {
          _tempUserData['targetWeight'] = target;
          await _addAiMessage(_l10n.chatTargetWeightConfirmation(target));
          _currentStep = 'activity';
        } else {
          _addAiMessage(_l10n.chatTargetWeightError);
          return;
        }
        break;
      // Activity and Goal are handled by widgets, but user might type
      case 'activity':
        _addAiMessage(_l10n.chatSelectOptionAbove);
        return;
      case 'goal':
        _addAiMessage(_l10n.chatSelectOptionAbove);
        return;
    }

    // Save progress
    await firestoreService.updateOnboardingStep(user.uid, _currentStep);
    
    // Save partial profile data
    if (_tempUserData.containsKey('name') && _tempUserData.containsKey('gender')) {
       final profile = UserProfile(
         name: _tempUserData['name'],
         gender: _tempUserData['gender'],
         age: _tempUserData['age'] ?? 0,
         height: _tempUserData['height'] ?? 0,
         updatedAt: DateTime.now(),
       );
       await firestoreService.saveUserProfile(user.uid, profile);
    }

    // Get next prompt
    final prompt = onboardingService.getPromptForStep(_currentStep, userData: _tempUserData);
    
    // Check for widgets and add them AFTER the message
    if (prompt.contains('WIDGET:gender_selector')) {
      await _addAiMessage(prompt.replaceAll('WIDGET:gender_selector', '').trim());
      _addWidgetMessage('gender_selector', {});
    } else if (prompt.contains('WIDGET:activity_selector')) {
      await _addAiMessage(prompt.replaceAll('WIDGET:activity_selector', '').trim());
      _addWidgetMessage('activity_selector', {});
    } else if (prompt.contains('WIDGET:goal_selector')) {
      await _addAiMessage(prompt.replaceAll('WIDGET:goal_selector', '').trim());
      _addWidgetMessage('goal_selector', {});
    } else if (prompt.contains('ONBOARDING:COMPLETE')) {
      await firestoreService.completeOnboarding(user.uid);
      _isOnboarding = false;
      await _addAiMessage("Tudo pronto! Vamos começar a registrar suas refeições. O que você comeu hoje?");
    } else {
      await _addAiMessage(prompt);
    }
  }

  Future<void> handleWidgetAction(String widgetType, dynamic value) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final firestoreService = ref.read(firestoreUserServiceProvider);
    final onboardingService = ref.read(onboardingServiceProvider);

    if (widgetType == 'gender_selector') {
      print('DEBUG handleWidgetAction: gender_selector received, value=$value');
      _tempUserData['gender'] = value; // Gender enum
      await _addAiMessage(_l10n.chatGenderConfirmation);
      _currentStep = 'profile_photo';
      print('DEBUG handleWidgetAction: currentStep set to $_currentStep');
      await firestoreService.updateOnboardingStep(user.uid, _currentStep);

      // Save partial profile
      final profile = UserProfile(
        name: _tempUserData['name'],
        gender: _tempUserData['gender'],
        age: _tempUserData['age'] ?? 0,
        height: _tempUserData['height'] ?? 0,
        updatedAt: DateTime.now(),
      );
      await firestoreService.saveUserProfile(user.uid, profile);

      // Show profile photo selector
      final prompt = onboardingService.getPromptForStep(_currentStep, userData: _tempUserData);
      print('DEBUG handleWidgetAction: prompt for profile_photo = $prompt');
      await _addAiMessage(prompt.replaceAll('WIDGET:profile_photo_selector', '').trim());
      print('DEBUG handleWidgetAction: adding profile_photo_selector widget, isMale=${_tempUserData['gender'] == Gender.male}');
      _addWidgetMessage('profile_photo_selector', {
        'isMale': _tempUserData['gender'] == Gender.male,
      });
      print('DEBUG handleWidgetAction: widget added');

    } else if (widgetType == 'profile_photo_selector') {
      final photoData = value as Map<String, dynamic>;

      // Save profile photo
      if (photoData['type'] == 'avatar') {
        await firestoreService.saveProfilePhoto(
          user.uid,
          avatarId: photoData['avatarId'],
          avatarUrl: photoData['avatarUrl'],
        );
        _tempUserData['avatarId'] = photoData['avatarId'];
        _tempUserData['avatarUrl'] = photoData['avatarUrl'];
        // Update local provider
        ref.read(userProfilePhotoProvider.notifier).updatePhoto(
          avatarId: photoData['avatarId'],
          avatarUrl: photoData['avatarUrl'],
        );
      } else {
        // For real photos, we'd need to upload to storage first
        // For now, just save the local path (TODO: implement Firebase Storage upload)
        await firestoreService.saveProfilePhoto(
          user.uid,
          photoUrl: photoData['photoPath'],
        );
        _tempUserData['photoUrl'] = photoData['photoPath'];
        // Update local provider
        ref.read(userProfilePhotoProvider.notifier).updatePhoto(
          photoUrl: photoData['photoPath'],
        );
      }

      await _addAiMessage(_l10n.profilePhotoConfirmation);

      // Only show tip if onboarding (not changing photo later)
      if (_isOnboarding) {
        await _addAiMessage(_l10n.profilePhotoTip);
        // Continue to age step
        _currentStep = 'age';
        await firestoreService.updateOnboardingStep(user.uid, _currentStep);
        final prompt = onboardingService.getPromptForStep(_currentStep, userData: _tempUserData);
        await _addAiMessage(prompt);
      }

    } else if (widgetType == 'activity_selector') {
      _tempUserData['activityLevel'] = value; // ActivityLevel enum
      await _addAiMessage(_l10n.chatActivityConfirmation);
      _currentStep = 'goal';
      await firestoreService.updateOnboardingStep(user.uid, _currentStep);
      
      final prompt = onboardingService.getPromptForStep('goal');
      await _addAiMessage(prompt.replaceAll('WIDGET:goal_selector', '').trim());
      _addWidgetMessage('goal_selector', {});
      
    } else if (widgetType == 'goal_selector') {
      _tempUserData['objective'] = value; // WeightGoal enum
      _currentStep = 'results';

      // Calculate TDEE
      final results = TDEECalculator.calculateAll(
        weight: _tempUserData['currentWeight'],
        height: _tempUserData['height'],
        age: _tempUserData['age'],
        gender: _tempUserData['gender'],
        activityLevel: _tempUserData['activityLevel'],
        goal: _tempUserData['objective'],
      );

      _tempUserData.addAll(results);

      // Save everything
      await firestoreService.saveWeightTracking(user.uid, WeightTracking(
        initialWeight: _tempUserData['initialWeight'],
        currentWeight: _tempUserData['currentWeight'],
        targetWeight: _tempUserData['targetWeight'],
        lastUpdatedAt: DateTime.now(),
      ));

      await firestoreService.saveUserGoals(user.uid, UserGoals(
        activityLevel: _tempUserData['activityLevel'],
        objective: _tempUserData['objective'],
        tdee: results['tdee'],
        bmr: results['bmr'],
        dailyCalorieTarget: results['dailyCalorieTarget'],
        macroTargets: Map<String, int>.from(results['macroTargets']),
        calculatedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      await firestoreService.updateOnboardingStep(user.uid, _currentStep);

      // Show results and then tutorial
      final resultsPrompt = onboardingService.getPromptForStep('results', userData: _tempUserData);
      await _addAiMessage(resultsPrompt);

      // Continue to tutorial
      _currentStep = 'tutorial';
      await firestoreService.updateOnboardingStep(user.uid, _currentStep);
      final tutorialPrompt = onboardingService.getPromptForStep('tutorial', userData: _tempUserData);

      // Process tutorial prompt for ONBOARDING:COMPLETE
      if (tutorialPrompt.contains('ONBOARDING:COMPLETE')) {
        await _addAiMessage(tutorialPrompt.replaceAll('ONBOARDING:COMPLETE', '').trim());
        await firestoreService.completeOnboarding(user.uid);
        _isOnboarding = false;
      } else {
        await _addAiMessage(tutorialPrompt);
      }
    } else if (widgetType == 'language_selector') {
      final languageCode = value as String;

      // Salvar e atualizar idioma
      await ref.read(localeProvider.notifier).saveToFirestore(user.uid, languageCode);

      // Marcar que o usuário já selecionou o idioma
      await firestoreService.markLanguageSelected(user.uid);

      // Se estiver na etapa de seleção inicial de idioma (primeiro acesso)
      if (_currentStep == 'language_selection') {
        // Obter l10n atualizado no novo idioma
        final newL10n = ref.read(l10nProvider);

        // Mostrar dica sobre mudança de idioma
        await _addAiMessage(newL10n.onboardingLanguageTip);

        // Continuar para o onboarding normal
        _currentStep = 'welcome';
        await firestoreService.updateOnboardingStep(user.uid, _currentStep);

        // Re-obter onboardingService com o novo idioma
        final updatedOnboardingService = ref.read(onboardingServiceProvider);
        final prompt = updatedOnboardingService.getPromptForStep(_currentStep, userData: _tempUserData);
        await _addAiMessage(prompt);
      } else {
        // Mudança de idioma durante uso normal - mostrar confirmação
        final newL10n = ref.read(l10nProvider);
        final languageName = languageNames[languageCode] ?? languageCode;
        await _addAiMessage(newL10n.languageChanged(languageName));
      }
    }
  }

  Future<void> _handleNormalMessage(String text) async {
    final aiService = ref.read(aiServiceProvider);
    
    final context = state
        .where((m) => m.type == MessageType.text)
        .map((m) => {
              "role": m.sender == MessageSender.user ? "user" : "assistant",
              "content": m.content,
            })
        .toList();

    try {
      final foodData = await aiService.analyzeFood(text);
      final aiResponse = await aiService.generateResponse(text, context);
      
      if (aiResponse.contains('WIDGET:daily_summary')) {
        final responseText = aiResponse.replaceAll('WIDGET:daily_summary', '').trim();
        _addAiMessage(responseText.isEmpty ? _l10n.chatDailySummaryDefault : responseText);
        
        _addWidgetMessage('daily_summary', {
            "calories": foodData?['calories']?.toInt() ?? 1300,
            "protein": foodData?['protein']?.toInt() ?? 120,
            "carbs": foodData?['carbs']?.toInt() ?? 150,
            "fat": foodData?['fat']?.toInt() ?? 45,
            "foodName": foodData?['name'],
        });
      } else {
        String enrichedResponse = aiResponse;
        if (foodData != null) {
          enrichedResponse += "\n\n📊 ${foodData['name']}: ${foodData['calories']}kcal (P: ${foodData['protein']}g, C: ${foodData['carbs']}g, G: ${foodData['fat']}g)";
        }
        _addAiMessage(enrichedResponse);
      }
    } catch (e) {
      _addAiMessage(_l10n.chatProcessingError);
    }
  }

  Future<void> _addAiMessage(String content) async {
    if (content.contains('|||')) {
      final parts = content.split('|||');
      for (final part in parts) {
        if (part.trim().isNotEmpty) {
          await _addSingleAiMessage(part.trim());
        }
      }
    } else {
      await _addSingleAiMessage(content);
    }
  }

  Future<void> _addSingleAiMessage(String content) async {
    // Add typing indicator
    final typingId = const Uuid().v4();
    state = [
      ...state,
      ChatMessage(
        id: typingId,
        content: "",
        sender: MessageSender.ai,
        type: MessageType.typing,
        timestamp: DateTime.now(),
      ),
    ];

    // Calculate delay based on message length (approx 50ms per character, min 1s, max 3s)
    final delayMs = (content.length * 50).clamp(1000, 3000);
    await Future.delayed(Duration(milliseconds: delayMs));

    // Remove typing indicator and add actual message
    state = [
      ...state.where((m) => m.id != typingId),
      ChatMessage(
        id: const Uuid().v4(),
        content: content,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      ),
    ];
  }

  void _addWidgetMessage(String type, Map<String, dynamic> metadata) {
    state = [
      ...state,
      ChatMessage(
        id: const Uuid().v4(),
        content: "",
        sender: MessageSender.ai,
        type: MessageType.widget,
        timestamp: DateTime.now(),
        metadata: {
          "widgetType": type,
          ...metadata,
        },
      ),
    ];
  }

  Future<void> sendImage(String path) async {
    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: path,
      sender: MessageSender.user,
      type: MessageType.image,
      timestamp: DateTime.now(),
    );
    state = [...state, userMessage];

    // Simulate AI analysis
    _addAiMessage(_l10n.chatImageAnalyzing);

    await Future.delayed(const Duration(seconds: 2));

    // Mock response for nutrition label or food (TODO: This should come from AI)
    _addAiMessage("📊 Greek Yogurt:\n• Calories: 120kcal\n• Protein: 12g\n• Carbs: 8g\n• Fat: 0g");
  }
}
