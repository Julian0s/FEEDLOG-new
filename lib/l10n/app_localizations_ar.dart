// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get loadingText => 'جاري التحميل...';

  @override
  String get onboardingWelcomeMessage =>
      'مرحباً! 👋 أهلاً بك في FEEDLOG! أنا مساعدك الغذائي بالذكاء الاصطناعي، وأنا سعيد بمساعدتك في تحقيق أهدافك الصحية!\n\nدعنا نكمل ملفك الشخصي حتى أتمكن من تقديم أفضل دعم لك.|||ماذا تريد أن أناديك؟';

  @override
  String onboardingNameConfirmation(String name) {
    return 'سعيد بلقائك، $name! 😊 الآن أحتاج لمعرفة جنسك البيولوجي لحساب ملفك الغذائي بدقة.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'ممتاز، $name! 😊 لحساب ملفك الغذائي بدقة، أحتاج لمعرفة جنسك البيولوجي. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => 'رائع! الآن أخبرني: كم عمرك؟';

  @override
  String get onboardingHeightPrompt =>
      'ممتاز! وما هو طولك؟ (بالأمتار أو السنتيمترات)';

  @override
  String get onboardingWeightPrompt => 'فهمت! الآن أخبرني: ما هو وزنك الحالي؟';

  @override
  String get onboardingTargetWeightPrompt =>
      'تم التسجيل! وما هو وزنك المستهدف؟ (الوزن الذي تريد الوصول إليه)';

  @override
  String get onboardingActivityPrompt =>
      'لحساب استهلاكك للسعرات الحرارية، أحتاج لمعرفة: ما هو مستوى نشاطك البدني اليومي؟\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'رائع! سؤال أخير: ما هو هدفك الرئيسي؟\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 اكتمل الملف، $name!\n\nلقد حسبت ملفك الغذائي:\n• TDEE: $tdee سعرة/يوم\n• الهدف اليومي: $dailyCalories سعرة\n• البروتين: $proteinغ\n• الكربوهيدرات: $carbsغ\n• الدهون: $fatغ\n\nالآن سأريك كيف تستخدم FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 كيف يعمل FEEDLOG:\n\n1️⃣ **تسجيل الوجبات**: فقط أخبرني ماذا أكلت! مثال: \'أكلت بيضتين وموزة\'\n\n2️⃣ **متابعة التقدم**: اسأل \'كم سعرة أكلت اليوم؟\' أو \'كيف يومي؟\'\n\n3️⃣ **تحديث الوزن**: قل \'خسرت 1 كغ\' أو \'وزني 80 كغ\'\n\n4️⃣ **الاستعلام عن الأطعمة**: اسأل \'كم سعرة في التفاحة؟\'\n\nكل شيء يعمل من خلال التحدث معي بشكل طبيعي! مستعد للبدء؟ 🚀';

  @override
  String get chatWelcomeBack => 'أهلاً بعودتك! ماذا أكلت اليوم؟';

  @override
  String get chatNameError =>
      'عذراً، لم أتمكن من تحديد اسمك. هل يمكنك كتابة ماذا تريد أن أناديك فقط؟';

  @override
  String chatAgeConfirmation(int age) {
    return '$age سنة، تم التسجيل! ✅';
  }

  @override
  String get chatAgeError => 'الرجاء إدخال عمر صحيح (مثال: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '$heightم، رائع! ✅';
  }

  @override
  String get chatHeightError =>
      'لم أفهم الطول. جرب شيئاً مثل \'1.75\' أو \'175سم\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '$weight كغ تم التسجيل! ✅';
  }

  @override
  String get chatWeightError => 'لم أفهم الوزن. جرب شيئاً مثل \'80كغ\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'هدف $weight كغ تم تعيينه! 💪';
  }

  @override
  String get chatTargetWeightError => 'ما هو وزنك المستهدف؟ مثال: \'70كغ\'.';

  @override
  String get chatSelectOptionAbove => 'الرجاء اختيار خيار من الأعلى.';

  @override
  String get chatGenderConfirmation => 'تم التسجيل! ✅';

  @override
  String get chatActivityConfirmation => 'ممتاز! 💪';

  @override
  String get chatLogoutConfirmation =>
      'فهمت! جاري تسجيل الخروج... إلى اللقاء! 👋';

  @override
  String get chatProcessingError =>
      'عذراً، حدثت مشكلة في معالجة رسالتك. حاول مرة أخرى.';

  @override
  String get chatImageAnalyzing => 'جاري تحليل صورتك... 📸';

  @override
  String get chatDailySummaryDefault => 'إليك ملخصك اليومي:';

  @override
  String get chatInputPlaceholder => 'اكتب رسالتك...';

  @override
  String get loginTagline => 'مساعدك الغذائي بالذكاء الاصطناعي';

  @override
  String get loginEmailPlaceholder => 'البريد الإلكتروني';

  @override
  String get loginPasswordPlaceholder => 'كلمة المرور';

  @override
  String get loginEmailRequired => 'أدخل بريدك الإلكتروني';

  @override
  String get loginEmailInvalid => 'بريد إلكتروني غير صالح';

  @override
  String get loginPasswordRequired => 'أدخل كلمة المرور';

  @override
  String get loginPasswordLengthError =>
      'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginSignupLink => 'ليس لديك حساب؟ سجل';

  @override
  String get signupTitle => 'إنشاء حساب';

  @override
  String get signupSubtitle => 'انضم إلى FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'تأكيد كلمة المرور';

  @override
  String get signupConfirmPasswordRequired => 'أكد كلمة المرور';

  @override
  String get signupPasswordsMismatch => 'كلمات المرور غير متطابقة';

  @override
  String get signupTermsAcceptance =>
      'أوافق على شروط الاستخدام وسياسة الخصوصية';

  @override
  String get signupTermsRequired => 'يجب قبول الشروط للمتابعة';

  @override
  String get signupButton => 'إنشاء حساب';

  @override
  String get signupLoginLink => 'لديك حساب بالفعل؟ سجل الدخول';

  @override
  String get loadingVerification => 'جاري التحقق من تسجيل الدخول...';

  @override
  String get genderSelectorTitle => 'اختر جنسك البيولوجي';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get activitySelectorTitle => 'مستوى النشاط البدني';

  @override
  String get activitySedentary => 'خامل';

  @override
  String get activitySedentaryDesc => 'قليل أو بدون تمارين';

  @override
  String get activityLight => 'خفيف';

  @override
  String get activityLightDesc => 'تمارين خفيفة 1-3 أيام/أسبوع';

  @override
  String get activityModerate => 'معتدل';

  @override
  String get activityModerateDesc => 'تمارين معتدلة 3-5 أيام/أسبوع';

  @override
  String get activityHeavy => 'مكثف';

  @override
  String get activityHeavyDesc => 'تمارين مكثفة 6-7 أيام/أسبوع';

  @override
  String get activityAthlete => 'رياضي';

  @override
  String get activityAthleteDesc => 'تمارين مكثفة جداً، عمل بدني';

  @override
  String get goalSelectorTitle => 'هدفك الرئيسي';

  @override
  String get goalLose => 'خسارة الوزن';

  @override
  String get goalLoseDesc => 'عجز سعرات 500 سعرة/يوم';

  @override
  String get goalMaintain => 'الحفاظ على الوزن';

  @override
  String get goalMaintainDesc => 'نظام غذائي للمحافظة';

  @override
  String get goalGain => 'بناء العضلات';

  @override
  String get goalGainDesc => 'فائض سعرات 300 سعرة/يوم';

  @override
  String get dailySummaryTitle => 'الملخص اليومي';

  @override
  String get dailySummaryCalories => 'السعرات';

  @override
  String get dailySummaryProtein => 'البروتين';

  @override
  String get dailySummaryCarbs => 'الكربوهيدرات';

  @override
  String get dailySummaryFat => 'الدهون';

  @override
  String get dailySummaryLeft => 'المتبقي';

  @override
  String get dailySummaryKcal => 'سعرة';

  @override
  String get languageNotAvailable => 'هذه اللغة غير متوفرة بعد في FEEDLOG.';

  @override
  String get languageAvailableOptions => 'اللغات المتاحة';

  @override
  String get languageChangePrompt => 'هل تريد اختيار لغة مختلفة؟';

  @override
  String get languageChangeConfirm => 'تم تغيير اللغة بنجاح! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'هذه اللغة غير متوفرة. اللغات المتاحة: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'تم تغيير اللغة إلى $language! 🌍 من الآن سأرد بهذه اللغة.';
  }

  @override
  String get languageSelectorTitle => 'اختر اللغة';

  @override
  String get languageSelectorPrompt =>
      'إليك اللغات المتاحة. اختر اللغة التي تفضلها:';

  @override
  String get onboardingLanguagePrompt =>
      'مرحباً! 🌍 قبل أن نبدأ، اختر لغتك المفضلة:';

  @override
  String get onboardingLanguageTip =>
      '💡 **نصيحة:** يمكنك تغيير اللغة في أي وقت بسؤال \'ما هي اللغات المتاحة؟\' أو قول \'غيّر إلى [اللغة]\'.';

  @override
  String get profilePhotoTitle => 'صورة الملف الشخصي';

  @override
  String get profilePhotoRealTab => 'صورة حقيقية';

  @override
  String get profilePhotoAvatarTab => 'أفاتار';

  @override
  String get profilePhotoCamera => 'الكاميرا';

  @override
  String get profilePhotoGallery => 'المعرض';

  @override
  String get profilePhotoHint => 'اختر صورة أو حدد أفاتار أدناه';

  @override
  String get profilePhotoPrompt =>
      'الآن لنخصص ملفك الشخصي! 📸 يمكنك تحميل صورة حقيقية أو اختيار أحد الأفاتارات المرحة:';

  @override
  String get profilePhotoConfirmation =>
      'اختيار رائع! ملفك الشخصي يبدو جميلاً! 😊';

  @override
  String get profilePhotoTip =>
      '💡 **نصيحة:** يمكنك تغيير صورتك في أي وقت بقول \'غيّر صورتي\' أو \'غيّر الأفاتار\'.';

  @override
  String get profilePhotoChangeRequest =>
      'بالتأكيد! دعني أعرض لك خيارات تحديث صورة الملف الشخصي:';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
