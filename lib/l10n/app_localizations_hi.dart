// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'पुष्टि करें';

  @override
  String get loadingText => 'लोड हो रहा है...';

  @override
  String get onboardingWelcomeMessage =>
      'नमस्ते! 👋 FEEDLOG में आपका स्वागत है! मैं आपका AI पोषण सहायक हूं, और मैं आपके स्वास्थ्य लक्ष्यों को प्राप्त करने में आपकी मदद करने के लिए उत्साहित हूं!\n\nआइए आपकी प्रोफाइल पूरी करें ताकि मैं आपको सबसे अच्छा समर्थन दे सकूं।|||आप क्या बुलाना पसंद करेंगे?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'आपसे मिलकर खुशी हुई, $name! 😊 अब मुझे आपका जैविक लिंग जानना होगा ताकि आपकी पोषण प्रोफाइल सटीक रूप से गणना कर सकूं।';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'बहुत अच्छा, $name! 😊 आपकी पोषण प्रोफाइल की सटीक गणना के लिए, मुझे आपका जैविक लिंग जानना होगा। WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => 'बढ़िया! अब मुझे बताएं: आपकी उम्र क्या है?';

  @override
  String get onboardingHeightPrompt =>
      'परफेक्ट! और आपकी ऊंचाई क्या है? (मीटर या सेंटीमीटर में)';

  @override
  String get onboardingWeightPrompt =>
      'समझ गया! अब बताएं: आपका वर्तमान वजन क्या है?';

  @override
  String get onboardingTargetWeightPrompt =>
      'नोट कर लिया! और आपका लक्ष्य वजन क्या है? (वह वजन जो आप पाना चाहते हैं)';

  @override
  String get onboardingActivityPrompt =>
      'आपकी कैलोरी खपत की गणना के लिए, मुझे जानना होगा: आपकी दैनिक शारीरिक गतिविधि का स्तर क्या है?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'बढ़िया! अंतिम प्रश्न: आपका मुख्य लक्ष्य क्या है?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 प्रोफाइल पूरी, $name!\n\nमैंने आपकी पोषण प्रोफाइल की गणना की:\n• TDEE: $tdee kcal/दिन\n• दैनिक लक्ष्य: $dailyCalories kcal\n• प्रोटीन: ${protein}g\n• कार्बोहाइड्रेट: ${carbs}g\n• वसा: ${fat}g\n\nअब मैं आपको FEEDLOG का उपयोग करना सिखाऊंगा!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 FEEDLOG कैसे काम करता है:\n\n1️⃣ **भोजन रिकॉर्ड करें**: बस मुझे बताएं आपने क्या खाया! उदाहरण: \'मैंने 2 अंडे और एक केला खाया\'\n\n2️⃣ **प्रगति देखें**: पूछें \'आज मैंने कितनी कैलोरी खाई?\' या \'मेरा दिन कैसा है?\'\n\n3️⃣ **वजन अपडेट करें**: कहें \'मेरा 1kg कम हुआ\' या \'मेरा वजन 80kg है\'\n\n4️⃣ **भोजन जानकारी**: पूछें \'एक सेब में कितनी कैलोरी हैं?\'\n\nसब कुछ स्वाभाविक बातचीत से काम करता है! शुरू करने के लिए तैयार हैं? 🚀';

  @override
  String get chatWelcomeBack => 'वापसी पर स्वागत है! आज आपने क्या खाया?';

  @override
  String get chatNameError =>
      'क्षमा करें, मैं आपका नाम पहचान नहीं पाया। क्या आप बस लिख सकते हैं कि आप क्या बुलाना चाहते हैं?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age साल, नोट कर लिया! ✅';
  }

  @override
  String get chatAgeError => 'कृपया एक वैध उम्र दर्ज करें (उदाहरण: 30)।';

  @override
  String chatHeightConfirmation(String height) {
    return '$heightमी, बढ़िया! ✅';
  }

  @override
  String get chatHeightError =>
      'ऊंचाई समझ नहीं आई। \'1.75\' या \'175cm\' जैसा कुछ आज़माएं।';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg रिकॉर्ड किया! ✅';
  }

  @override
  String get chatWeightError => 'वजन समझ नहीं आया। \'80kg\' जैसा कुछ आज़माएं।';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'लक्ष्य ${weight}kg सेट किया! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'आपका लक्ष्य वजन क्या है? उदाहरण: \'70kg\'।';

  @override
  String get chatSelectOptionAbove => 'कृपया ऊपर से एक विकल्प चुनें।';

  @override
  String get chatGenderConfirmation => 'नोट कर लिया! ✅';

  @override
  String get chatActivityConfirmation => 'परफेक्ट! 💪';

  @override
  String get chatLogoutConfirmation =>
      'समझ गया! लॉग आउट हो रहा है... फिर मिलेंगे! 👋';

  @override
  String get chatProcessingError =>
      'क्षमा करें, आपके संदेश को प्रोसेस करने में समस्या हुई। कृपया फिर से कोशिश करें।';

  @override
  String get chatImageAnalyzing => 'आपकी छवि का विश्लेषण हो रहा है... 📸';

  @override
  String get chatDailySummaryDefault => 'यहां आपका दैनिक सारांश है:';

  @override
  String get chatInputPlaceholder => 'अपना संदेश लिखें...';

  @override
  String get loginTagline => 'आपका AI पोषण सहायक';

  @override
  String get loginEmailPlaceholder => 'ईमेल';

  @override
  String get loginPasswordPlaceholder => 'पासवर्ड';

  @override
  String get loginEmailRequired => 'अपना ईमेल दर्ज करें';

  @override
  String get loginEmailInvalid => 'अमान्य ईमेल';

  @override
  String get loginPasswordRequired => 'अपना पासवर्ड दर्ज करें';

  @override
  String get loginPasswordLengthError =>
      'पासवर्ड कम से कम 6 अक्षर का होना चाहिए';

  @override
  String get loginButton => 'साइन इन करें';

  @override
  String get loginSignupLink => 'खाता नहीं है? साइन अप करें';

  @override
  String get signupTitle => 'खाता बनाएं';

  @override
  String get signupSubtitle => 'FEEDLOG में शामिल हों';

  @override
  String get signupConfirmPasswordPlaceholder => 'पासवर्ड की पुष्टि करें';

  @override
  String get signupConfirmPasswordRequired => 'अपने पासवर्ड की पुष्टि करें';

  @override
  String get signupPasswordsMismatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get signupTermsAcceptance =>
      'मैं उपयोग की शर्तों और गोपनीयता नीति से सहमत हूं';

  @override
  String get signupTermsRequired =>
      'जारी रखने के लिए आपको शर्तों से सहमत होना होगा';

  @override
  String get signupButton => 'खाता बनाएं';

  @override
  String get signupLoginLink => 'पहले से खाता है? साइन इन करें';

  @override
  String get loadingVerification => 'लॉगिन सत्यापित हो रहा है...';

  @override
  String get genderSelectorTitle => 'अपना जैविक लिंग चुनें';

  @override
  String get genderMale => 'पुरुष';

  @override
  String get genderFemale => 'महिला';

  @override
  String get activitySelectorTitle => 'शारीरिक गतिविधि स्तर';

  @override
  String get activitySedentary => 'गतिहीन';

  @override
  String get activitySedentaryDesc => 'कम या कोई व्यायाम नहीं';

  @override
  String get activityLight => 'हल्का';

  @override
  String get activityLightDesc => 'हल्का व्यायाम 1-3 दिन/सप्ताह';

  @override
  String get activityModerate => 'मध्यम';

  @override
  String get activityModerateDesc => 'मध्यम व्यायाम 3-5 दिन/सप्ताह';

  @override
  String get activityHeavy => 'भारी';

  @override
  String get activityHeavyDesc => 'तीव्र व्यायाम 6-7 दिन/सप्ताह';

  @override
  String get activityAthlete => 'एथलीट';

  @override
  String get activityAthleteDesc => 'बहुत तीव्र व्यायाम, शारीरिक काम';

  @override
  String get goalSelectorTitle => 'आपका मुख्य लक्ष्य';

  @override
  String get goalLose => 'वजन कम करें';

  @override
  String get goalLoseDesc => '500 kcal/दिन कैलोरी कमी';

  @override
  String get goalMaintain => 'वजन बनाए रखें';

  @override
  String get goalMaintainDesc => 'रखरखाव आहार';

  @override
  String get goalGain => 'मांसपेशियां बढ़ाएं';

  @override
  String get goalGainDesc => '300 kcal/दिन कैलोरी अधिशेष';

  @override
  String get dailySummaryTitle => 'दैनिक सारांश';

  @override
  String get dailySummaryCalories => 'कैलोरी';

  @override
  String get dailySummaryProtein => 'प्रोटीन';

  @override
  String get dailySummaryCarbs => 'कार्बोहाइड्रेट';

  @override
  String get dailySummaryFat => 'वसा';

  @override
  String get dailySummaryLeft => 'बचा हुआ';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable => 'यह भाषा अभी FEEDLOG में उपलब्ध नहीं है।';

  @override
  String get languageAvailableOptions => 'उपलब्ध भाषाएं';

  @override
  String get languageChangePrompt => 'क्या आप कोई अन्य भाषा चुनना चाहेंगे?';

  @override
  String get languageChangeConfirm => 'भाषा सफलतापूर्वक बदल दी गई! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'यह भाषा उपलब्ध नहीं है। उपलब्ध भाषाएं: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'भाषा $language में बदल दी गई! 🌍 अब से मैं इस भाषा में जवाब दूंगा।';
  }

  @override
  String get languageSelectorTitle => 'भाषा चुनें';

  @override
  String get languageSelectorPrompt =>
      'यहाँ उपलब्ध भाषाएं हैं। अपनी पसंदीदा भाषा चुनें:';

  @override
  String get onboardingLanguagePrompt =>
      'स्वागत है! 🌍 शुरू करने से पहले, अपनी पसंदीदा भाषा चुनें:';

  @override
  String get onboardingLanguageTip =>
      '💡 **सुझाव:** आप \'कौन सी भाषाएं उपलब्ध हैं?\' पूछकर या \'[भाषा] में बदलें\' कहकर किसी भी समय भाषा बदल सकते हैं।';
}
