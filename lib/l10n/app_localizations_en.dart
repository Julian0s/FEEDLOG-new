// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get loadingText => 'Loading...';

  @override
  String get onboardingWelcomeMessage =>
      'Hello! 👋 Welcome to FEEDLOG! I\'m your AI-powered nutrition assistant, and I\'m excited to help you achieve your health goals!\n\nLet\'s complete your profile so I can provide you with the best possible support.|||What would you like to be called?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Nice to meet you, $name! 😊 Now I need to know your biological sex to accurately calculate your nutritional profile.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Perfect, $name! 😊 To calculate your nutritional profile accurately, I need to know your biological sex. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => 'Great! Now tell me: how old are you?';

  @override
  String get onboardingHeightPrompt =>
      'Perfect! And what\'s your height? (you can use meters or centimeters)';

  @override
  String get onboardingWeightPrompt =>
      'Got it! Now tell me: what\'s your current weight?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Noted! And what\'s your target weight? (the weight you want to reach)';

  @override
  String get onboardingActivityPrompt =>
      'To calculate your calorie expenditure, I need to know: what\'s your daily physical activity level?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Great! Last question: what\'s your main goal?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Profile complete, $name!\n\nI\'ve calculated your nutritional profile:\n• TDEE: $tdee kcal/day\n• Daily target: $dailyCalories kcal\n• Protein: ${protein}g\n• Carbohydrates: ${carbs}g\n• Fat: ${fat}g\n\nNow let me show you how to use FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 How FEEDLOG works:\n\n1️⃣ **Log meals**: Just tell me what you ate! Example: \'I ate 2 eggs and a banana\'\n\n2️⃣ **Track your progress**: Ask \'How many calories did I eat today?\' or \'How\'s my day going?\'\n\n3️⃣ **Update weight**: Say \'I lost 1kg\' or \'I\'m at 80kg\'\n\n4️⃣ **Check foods**: Ask \'How many calories are in an apple?\'\n\nEverything works by chatting with me naturally! Ready to start? 🚀';

  @override
  String get chatWelcomeBack => 'Welcome back! What did you eat today?';

  @override
  String get chatNameError =>
      'Sorry, I couldn\'t identify your name. Could you just type what you\'d like to be called?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age years old, noted! ✅';
  }

  @override
  String get chatAgeError => 'Please enter a valid age (e.g., 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m tall, great! ✅';
  }

  @override
  String get chatHeightError =>
      'I didn\'t understand the height. Try something like \'1.75\' or \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg registered! ✅';
  }

  @override
  String get chatWeightError =>
      'I didn\'t understand the weight. Try something like \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Target of ${weight}kg set! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'What\'s your target weight? E.g., \'70kg\'.';

  @override
  String get chatSelectOptionAbove => 'Please select an option above.';

  @override
  String get chatGenderConfirmation => 'Noted! ✅';

  @override
  String get chatActivityConfirmation => 'Perfect! 💪';

  @override
  String get chatLogoutConfirmation =>
      'Got it! Logging out... See you later! 👋';

  @override
  String get chatProcessingError =>
      'Sorry, I had a problem processing your message. Please try again.';

  @override
  String get chatImageAnalyzing => 'Analyzing your image... 📸';

  @override
  String get chatDailySummaryDefault => 'Here\'s your daily summary:';

  @override
  String get chatInputPlaceholder => 'Type your message...';

  @override
  String get loginTagline => 'Your AI-powered nutrition assistant';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Password';

  @override
  String get loginEmailRequired => 'Please enter your email';

  @override
  String get loginEmailInvalid => 'Invalid email';

  @override
  String get loginPasswordRequired => 'Please enter your password';

  @override
  String get loginPasswordLengthError =>
      'Password must be at least 6 characters';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginSignupLink => 'Don\'t have an account? Sign up';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get signupSubtitle => 'Join FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Confirm Password';

  @override
  String get signupConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get signupPasswordsMismatch => 'Passwords don\'t match';

  @override
  String get signupTermsAcceptance =>
      'I accept the terms of use and privacy policy';

  @override
  String get signupTermsRequired => 'You must accept the terms to continue';

  @override
  String get signupButton => 'Create Account';

  @override
  String get signupLoginLink => 'Already have an account? Sign in';

  @override
  String get loadingVerification => 'Verifying login...';

  @override
  String get genderSelectorTitle => 'Select Your Biological Sex';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get activitySelectorTitle => 'Physical Activity Level';

  @override
  String get activitySedentary => 'Sedentary';

  @override
  String get activitySedentaryDesc => 'Little or no exercise';

  @override
  String get activityLight => 'Light';

  @override
  String get activityLightDesc => 'Light exercise 1-3 days/week';

  @override
  String get activityModerate => 'Moderate';

  @override
  String get activityModerateDesc => 'Moderate exercise 3-5 days/week';

  @override
  String get activityHeavy => 'Heavy';

  @override
  String get activityHeavyDesc => 'Intense exercise 6-7 days/week';

  @override
  String get activityAthlete => 'Athlete';

  @override
  String get activityAthleteDesc => 'Very intense exercise, physical work';

  @override
  String get goalSelectorTitle => 'Your Main Goal';

  @override
  String get goalLose => 'Lose Weight';

  @override
  String get goalLoseDesc => 'Caloric deficit of 500 kcal/day';

  @override
  String get goalMaintain => 'Maintain Weight';

  @override
  String get goalMaintainDesc => 'Maintenance diet';

  @override
  String get goalGain => 'Build Muscle';

  @override
  String get goalGainDesc => 'Caloric surplus of 300 kcal/day';

  @override
  String get dailySummaryTitle => 'Daily Summary';

  @override
  String get dailySummaryCalories => 'Calories';

  @override
  String get dailySummaryProtein => 'Protein';

  @override
  String get dailySummaryCarbs => 'Carbs';

  @override
  String get dailySummaryFat => 'Fat';

  @override
  String get dailySummaryLeft => 'Left';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'This language is not yet available in FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Available languages';

  @override
  String get languageChangePrompt =>
      'Would you like to choose a different language?';

  @override
  String get languageChangeConfirm => 'Language changed successfully! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'This language is not available. Available languages: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Language changed to $language! 🌍 From now on I\'ll respond in this language.';
  }

  @override
  String get languageSelectorTitle => 'Select Language';

  @override
  String get languageSelectorPrompt =>
      'Here are the available languages. Select the one you prefer:';

  @override
  String get onboardingLanguagePrompt =>
      'Welcome! 🌍 Before we begin, please select your preferred language:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Tip:** You can change the language anytime by asking \'which languages are available?\' or saying \'change to [language]\'.';
}
