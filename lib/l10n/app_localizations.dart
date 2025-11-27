import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'FEEDLOG'**
  String get appTitle;

  /// Generic confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// Generic loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingText;

  /// Welcome message during onboarding
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋 Welcome to FEEDLOG! I\'m your AI-powered nutrition assistant, and I\'m excited to help you achieve your health goals!\n\nLet\'s complete your profile so I can provide you with the best possible support.|||What would you like to be called?'**
  String get onboardingWelcomeMessage;

  /// Confirmation after user provides name
  ///
  /// In en, this message translates to:
  /// **'Nice to meet you, {name}! 😊 Now I need to know your biological sex to accurately calculate your nutritional profile.'**
  String onboardingNameConfirmation(String name);

  /// Prompt for gender selection
  ///
  /// In en, this message translates to:
  /// **'Perfect, {name}! 😊 To calculate your nutritional profile accurately, I need to know your biological sex. WIDGET:gender_selector'**
  String onboardingGenderPrompt(String name);

  /// Prompt for age input
  ///
  /// In en, this message translates to:
  /// **'Great! Now tell me: how old are you?'**
  String get onboardingAgePrompt;

  /// Prompt for height input
  ///
  /// In en, this message translates to:
  /// **'Perfect! And what\'s your height? (you can use meters or centimeters)'**
  String get onboardingHeightPrompt;

  /// Prompt for weight input
  ///
  /// In en, this message translates to:
  /// **'Got it! Now tell me: what\'s your current weight?'**
  String get onboardingWeightPrompt;

  /// Prompt for target weight input
  ///
  /// In en, this message translates to:
  /// **'Noted! And what\'s your target weight? (the weight you want to reach)'**
  String get onboardingTargetWeightPrompt;

  /// Prompt for activity level selection
  ///
  /// In en, this message translates to:
  /// **'To calculate your calorie expenditure, I need to know: what\'s your daily physical activity level?\n\nWIDGET:activity_selector'**
  String get onboardingActivityPrompt;

  /// Prompt for goal selection
  ///
  /// In en, this message translates to:
  /// **'Great! Last question: what\'s your main goal?\n\nWIDGET:goal_selector'**
  String get onboardingGoalPrompt;

  /// Results after completing onboarding
  ///
  /// In en, this message translates to:
  /// **'🎉 Profile complete, {name}!\n\nI\'ve calculated your nutritional profile:\n• TDEE: {tdee} kcal/day\n• Daily target: {dailyCalories} kcal\n• Protein: {protein}g\n• Carbohydrates: {carbs}g\n• Fat: {fat}g\n\nNow let me show you how to use FEEDLOG!'**
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  );

  /// Tutorial message at end of onboarding
  ///
  /// In en, this message translates to:
  /// **'📱 How FEEDLOG works:\n\n1️⃣ **Log meals**: Just tell me what you ate! Example: \'I ate 2 eggs and a banana\'\n\n2️⃣ **Track your progress**: Ask \'How many calories did I eat today?\' or \'How\'s my day going?\'\n\n3️⃣ **Update weight**: Say \'I lost 1kg\' or \'I\'m at 80kg\'\n\n4️⃣ **Check foods**: Ask \'How many calories are in an apple?\'\n\nEverything works by chatting with me naturally! Ready to start? 🚀'**
  String get onboardingTutorialMessage;

  /// Welcome back message for returning users
  ///
  /// In en, this message translates to:
  /// **'Welcome back! What did you eat today?'**
  String get chatWelcomeBack;

  /// Error when name extraction fails
  ///
  /// In en, this message translates to:
  /// **'Sorry, I couldn\'t identify your name. Could you just type what you\'d like to be called?'**
  String get chatNameError;

  /// Confirmation of age
  ///
  /// In en, this message translates to:
  /// **'{age} years old, noted! ✅'**
  String chatAgeConfirmation(int age);

  /// Error for invalid age input
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age (e.g., 30).'**
  String get chatAgeError;

  /// Confirmation of height
  ///
  /// In en, this message translates to:
  /// **'{height}m tall, great! ✅'**
  String chatHeightConfirmation(String height);

  /// Error for invalid height input
  ///
  /// In en, this message translates to:
  /// **'I didn\'t understand the height. Try something like \'1.75\' or \'175cm\'.'**
  String get chatHeightError;

  /// Confirmation of weight
  ///
  /// In en, this message translates to:
  /// **'{weight}kg registered! ✅'**
  String chatWeightConfirmation(double weight);

  /// Error for invalid weight input
  ///
  /// In en, this message translates to:
  /// **'I didn\'t understand the weight. Try something like \'80kg\'.'**
  String get chatWeightError;

  /// Confirmation of target weight
  ///
  /// In en, this message translates to:
  /// **'Target of {weight}kg set! 💪'**
  String chatTargetWeightConfirmation(double weight);

  /// Error for invalid target weight input
  ///
  /// In en, this message translates to:
  /// **'What\'s your target weight? E.g., \'70kg\'.'**
  String get chatTargetWeightError;

  /// Prompt to select from widget options
  ///
  /// In en, this message translates to:
  /// **'Please select an option above.'**
  String get chatSelectOptionAbove;

  /// Confirmation after gender selection
  ///
  /// In en, this message translates to:
  /// **'Noted! ✅'**
  String get chatGenderConfirmation;

  /// Confirmation after activity selection
  ///
  /// In en, this message translates to:
  /// **'Perfect! 💪'**
  String get chatActivityConfirmation;

  /// Message when user logs out
  ///
  /// In en, this message translates to:
  /// **'Got it! Logging out... See you later! 👋'**
  String get chatLogoutConfirmation;

  /// Generic processing error message
  ///
  /// In en, this message translates to:
  /// **'Sorry, I had a problem processing your message. Please try again.'**
  String get chatProcessingError;

  /// Message while analyzing image
  ///
  /// In en, this message translates to:
  /// **'Analyzing your image... 📸'**
  String get chatImageAnalyzing;

  /// Default message before daily summary widget
  ///
  /// In en, this message translates to:
  /// **'Here\'s your daily summary:'**
  String get chatDailySummaryDefault;

  /// Placeholder text for chat input
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get chatInputPlaceholder;

  /// Tagline on login screen
  ///
  /// In en, this message translates to:
  /// **'Your AI-powered nutrition assistant'**
  String get loginTagline;

  /// Email field placeholder
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailPlaceholder;

  /// Password field placeholder
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordPlaceholder;

  /// Error when email is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get loginEmailRequired;

  /// Error when email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get loginEmailInvalid;

  /// Error when password is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get loginPasswordRequired;

  /// Error when password is too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get loginPasswordLengthError;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButton;

  /// Link to signup page
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get loginSignupLink;

  /// Title on signup screen
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// Subtitle on signup screen
  ///
  /// In en, this message translates to:
  /// **'Join FEEDLOG'**
  String get signupSubtitle;

  /// Confirm password field placeholder
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signupConfirmPasswordPlaceholder;

  /// Error when confirm password is empty
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get signupConfirmPasswordRequired;

  /// Error when passwords don't match
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get signupPasswordsMismatch;

  /// Terms acceptance checkbox text
  ///
  /// In en, this message translates to:
  /// **'I accept the terms of use and privacy policy'**
  String get signupTermsAcceptance;

  /// Error when terms not accepted
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms to continue'**
  String get signupTermsRequired;

  /// Signup button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupButton;

  /// Link to login page
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get signupLoginLink;

  /// Loading screen verification text
  ///
  /// In en, this message translates to:
  /// **'Verifying login...'**
  String get loadingVerification;

  /// Title for gender selector widget
  ///
  /// In en, this message translates to:
  /// **'Select Your Biological Sex'**
  String get genderSelectorTitle;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// Title for activity selector widget
  ///
  /// In en, this message translates to:
  /// **'Physical Activity Level'**
  String get activitySelectorTitle;

  /// Sedentary activity level
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get activitySedentary;

  /// Description for sedentary level
  ///
  /// In en, this message translates to:
  /// **'Little or no exercise'**
  String get activitySedentaryDesc;

  /// Light activity level
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get activityLight;

  /// Description for light activity level
  ///
  /// In en, this message translates to:
  /// **'Light exercise 1-3 days/week'**
  String get activityLightDesc;

  /// Moderate activity level
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get activityModerate;

  /// Description for moderate activity level
  ///
  /// In en, this message translates to:
  /// **'Moderate exercise 3-5 days/week'**
  String get activityModerateDesc;

  /// Heavy activity level
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get activityHeavy;

  /// Description for heavy activity level
  ///
  /// In en, this message translates to:
  /// **'Intense exercise 6-7 days/week'**
  String get activityHeavyDesc;

  /// Athlete activity level
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get activityAthlete;

  /// Description for athlete activity level
  ///
  /// In en, this message translates to:
  /// **'Very intense exercise, physical work'**
  String get activityAthleteDesc;

  /// Title for goal selector widget
  ///
  /// In en, this message translates to:
  /// **'Your Main Goal'**
  String get goalSelectorTitle;

  /// Weight loss goal
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get goalLose;

  /// Description for weight loss goal
  ///
  /// In en, this message translates to:
  /// **'Caloric deficit of 500 kcal/day'**
  String get goalLoseDesc;

  /// Weight maintenance goal
  ///
  /// In en, this message translates to:
  /// **'Maintain Weight'**
  String get goalMaintain;

  /// Description for weight maintenance goal
  ///
  /// In en, this message translates to:
  /// **'Maintenance diet'**
  String get goalMaintainDesc;

  /// Muscle building goal
  ///
  /// In en, this message translates to:
  /// **'Build Muscle'**
  String get goalGain;

  /// Description for muscle building goal
  ///
  /// In en, this message translates to:
  /// **'Caloric surplus of 300 kcal/day'**
  String get goalGainDesc;

  /// Title for daily summary widget
  ///
  /// In en, this message translates to:
  /// **'Daily Summary'**
  String get dailySummaryTitle;

  /// Calories label
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get dailySummaryCalories;

  /// Protein label
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get dailySummaryProtein;

  /// Carbohydrates label
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get dailySummaryCarbs;

  /// Fat label
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get dailySummaryFat;

  /// Remaining amount label
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get dailySummaryLeft;

  /// Kilocalories unit
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get dailySummaryKcal;

  /// Message when requested language is not supported
  ///
  /// In en, this message translates to:
  /// **'This language is not yet available in FEEDLOG.'**
  String get languageNotAvailable;

  /// Label for available languages list
  ///
  /// In en, this message translates to:
  /// **'Available languages'**
  String get languageAvailableOptions;

  /// Prompt asking if user wants to select another language
  ///
  /// In en, this message translates to:
  /// **'Would you like to choose a different language?'**
  String get languageChangePrompt;

  /// Confirmation when language is changed
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully! 🌍'**
  String get languageChangeConfirm;

  /// Message when requested language is not supported with list
  ///
  /// In en, this message translates to:
  /// **'This language is not available. Available languages: {languages}'**
  String languageNotSupported(String languages);

  /// Confirmation when language is changed
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}! 🌍 From now on I\'ll respond in this language.'**
  String languageChanged(String language);

  /// Title for language selector widget
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelectorTitle;

  /// Prompt message before showing language selector
  ///
  /// In en, this message translates to:
  /// **'Here are the available languages. Select the one you prefer:'**
  String get languageSelectorPrompt;

  /// Prompt for language selection at first access
  ///
  /// In en, this message translates to:
  /// **'Welcome! 🌍 Before we begin, please select your preferred language:'**
  String get onboardingLanguagePrompt;

  /// Tip about changing language after initial selection
  ///
  /// In en, this message translates to:
  /// **'💡 **Tip:** You can change the language anytime by asking \'which languages are available?\' or saying \'change to [language]\'.'**
  String get onboardingLanguageTip;

  /// Title for profile photo selector
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhotoTitle;

  /// Tab for real photo option
  ///
  /// In en, this message translates to:
  /// **'Real Photo'**
  String get profilePhotoRealTab;

  /// Tab for avatar option
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get profilePhotoAvatarTab;

  /// Camera option label
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get profilePhotoCamera;

  /// Gallery option label
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get profilePhotoGallery;

  /// Hint text for photo selection
  ///
  /// In en, this message translates to:
  /// **'Choose a photo or select an avatar below'**
  String get profilePhotoHint;

  /// Prompt for profile photo selection during onboarding
  ///
  /// In en, this message translates to:
  /// **'Now let\'s personalize your profile! 📸 You can upload a real photo or choose one of our fun avatars:'**
  String get profilePhotoPrompt;

  /// Confirmation after photo/avatar selection
  ///
  /// In en, this message translates to:
  /// **'Great choice! Your profile is looking good! 😊'**
  String get profilePhotoConfirmation;

  /// Tip about changing photo later
  ///
  /// In en, this message translates to:
  /// **'💡 **Tip:** You can change your photo anytime by saying \'change my photo\' or \'change my avatar\'.'**
  String get profilePhotoTip;

  /// Response when user asks to change photo
  ///
  /// In en, this message translates to:
  /// **'Sure! Let me show you the options to update your profile photo:'**
  String get profilePhotoChangeRequest;

  /// Button to reload/generate new avatars
  ///
  /// In en, this message translates to:
  /// **'New avatars'**
  String get reloadAvatars;

  /// Title for recent avatars dialog
  ///
  /// In en, this message translates to:
  /// **'Recent avatars'**
  String get recentAvatars;

  /// Generic close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
