// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get loadingText => 'Загрузка...';

  @override
  String get onboardingWelcomeMessage =>
      'Привет! 👋 Добро пожаловать в FEEDLOG! Я твой ИИ-помощник по питанию, и я рад помочь тебе достичь твоих целей здоровья!\n\nДавай заполним твой профиль, чтобы я мог предоставить тебе лучшую поддержку.|||Как бы ты хотел, чтобы я тебя называл?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Приятно познакомиться, $name! 😊 Теперь мне нужно узнать твой биологический пол для точного расчёта твоего нутриционного профиля.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Отлично, $name! 😊 Для точного расчёта твоего нутриционного профиля мне нужно знать твой биологический пол. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt =>
      'Супер! Теперь скажи мне: сколько тебе лет?';

  @override
  String get onboardingHeightPrompt =>
      'Отлично! А какой у тебя рост? (можно в метрах или сантиметрах)';

  @override
  String get onboardingWeightPrompt =>
      'Понял! Теперь скажи: какой у тебя текущий вес?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Записал! А какой твой целевой вес? (вес, которого ты хочешь достичь)';

  @override
  String get onboardingActivityPrompt =>
      'Чтобы рассчитать твой расход калорий, мне нужно знать: каков твой уровень физической активности в повседневной жизни?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Супер! Последний вопрос: какая твоя главная цель?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Профиль готов, $name!\n\nЯ рассчитал твой нутриционный профиль:\n• TDEE: $tdee ккал/день\n• Дневная цель: $dailyCalories ккал\n• Белок: $proteinг\n• Углеводы: $carbsг\n• Жиры: $fatг\n\nТеперь покажу, как пользоваться FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 Как работает FEEDLOG:\n\n1️⃣ **Записывать приёмы пищи**: Просто расскажи, что ты съел! Пример: \'Я съел 2 яйца и банан\'\n\n2️⃣ **Смотреть прогресс**: Спроси \'Сколько калорий я съел сегодня?\' или \'Как мой день?\'\n\n3️⃣ **Обновлять вес**: Скажи \'Я похудел на 1кг\' или \'Я вешу 80кг\'\n\n4️⃣ **Узнавать о продуктах**: Спроси \'Сколько калорий в яблоке?\'\n\nВсё работает через естественное общение со мной! Готов начать? 🚀';

  @override
  String get chatWelcomeBack => 'С возвращением! Что ты ел сегодня?';

  @override
  String get chatNameError =>
      'Извини, я не смог распознать твоё имя. Можешь просто написать, как тебя называть?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age лет, записал! ✅';
  }

  @override
  String get chatAgeError =>
      'Пожалуйста, введи корректный возраст (например: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '$heightм роста, супер! ✅';
  }

  @override
  String get chatHeightError =>
      'Не понял рост. Попробуй что-то вроде \'1.75\' или \'175см\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '$weightкг записано! ✅';
  }

  @override
  String get chatWeightError => 'Не понял вес. Попробуй что-то вроде \'80кг\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Цель $weightкг установлена! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'Какой твой целевой вес? Например: \'70кг\'.';

  @override
  String get chatSelectOptionAbove => 'Пожалуйста, выбери вариант выше.';

  @override
  String get chatGenderConfirmation => 'Записал! ✅';

  @override
  String get chatActivityConfirmation => 'Отлично! 💪';

  @override
  String get chatLogoutConfirmation => 'Понял! Выхожу... До встречи! 👋';

  @override
  String get chatProcessingError =>
      'Извини, возникла проблема при обработке твоего сообщения. Попробуй ещё раз.';

  @override
  String get chatImageAnalyzing => 'Анализирую твоё изображение... 📸';

  @override
  String get chatDailySummaryDefault => 'Вот твоя дневная сводка:';

  @override
  String get chatInputPlaceholder => 'Введи сообщение...';

  @override
  String get loginTagline => 'Твой ИИ-помощник по питанию';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Пароль';

  @override
  String get loginEmailRequired => 'Введи свой email';

  @override
  String get loginEmailInvalid => 'Неверный email';

  @override
  String get loginPasswordRequired => 'Введи свой пароль';

  @override
  String get loginPasswordLengthError =>
      'Пароль должен быть минимум 6 символов';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginSignupLink => 'Нет аккаунта? Зарегистрируйся';

  @override
  String get signupTitle => 'Создать аккаунт';

  @override
  String get signupSubtitle => 'Присоединяйся к FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Подтвердить пароль';

  @override
  String get signupConfirmPasswordRequired => 'Подтверди свой пароль';

  @override
  String get signupPasswordsMismatch => 'Пароли не совпадают';

  @override
  String get signupTermsAcceptance =>
      'Я принимаю условия использования и политику конфиденциальности';

  @override
  String get signupTermsRequired =>
      'Для продолжения необходимо принять условия';

  @override
  String get signupButton => 'Создать аккаунт';

  @override
  String get signupLoginLink => 'Уже есть аккаунт? Войти';

  @override
  String get loadingVerification => 'Проверка входа...';

  @override
  String get genderSelectorTitle => 'Выбери свой биологический пол';

  @override
  String get genderMale => 'Мужской';

  @override
  String get genderFemale => 'Женский';

  @override
  String get activitySelectorTitle => 'Уровень физической активности';

  @override
  String get activitySedentary => 'Сидячий';

  @override
  String get activitySedentaryDesc => 'Мало или нет упражнений';

  @override
  String get activityLight => 'Лёгкий';

  @override
  String get activityLightDesc => 'Лёгкие упражнения 1-3 дня/неделю';

  @override
  String get activityModerate => 'Умеренный';

  @override
  String get activityModerateDesc => 'Умеренные упражнения 3-5 дней/неделю';

  @override
  String get activityHeavy => 'Интенсивный';

  @override
  String get activityHeavyDesc => 'Интенсивные упражнения 6-7 дней/неделю';

  @override
  String get activityAthlete => 'Атлет';

  @override
  String get activityAthleteDesc =>
      'Очень интенсивные упражнения, физическая работа';

  @override
  String get goalSelectorTitle => 'Твоя главная цель';

  @override
  String get goalLose => 'Похудеть';

  @override
  String get goalLoseDesc => 'Дефицит калорий 500 ккал/день';

  @override
  String get goalMaintain => 'Поддерживать вес';

  @override
  String get goalMaintainDesc => 'Поддерживающая диета';

  @override
  String get goalGain => 'Набрать массу';

  @override
  String get goalGainDesc => 'Избыток калорий 300 ккал/день';

  @override
  String get dailySummaryTitle => 'Дневная сводка';

  @override
  String get dailySummaryCalories => 'Калории';

  @override
  String get dailySummaryProtein => 'Белок';

  @override
  String get dailySummaryCarbs => 'Углеводы';

  @override
  String get dailySummaryFat => 'Жиры';

  @override
  String get dailySummaryLeft => 'Осталось';

  @override
  String get dailySummaryKcal => 'ккал';

  @override
  String get languageNotAvailable => 'Этот язык пока не доступен в FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Доступные языки';

  @override
  String get languageChangePrompt => 'Хочешь выбрать другой язык?';

  @override
  String get languageChangeConfirm => 'Язык успешно изменён! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Этот язык недоступен. Доступные языки: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Язык изменён на $language! 🌍 Теперь я буду отвечать на этом языке.';
  }

  @override
  String get languageSelectorTitle => 'Выберите язык';

  @override
  String get languageSelectorPrompt =>
      'Вот доступные языки. Выберите предпочтительный:';

  @override
  String get onboardingLanguagePrompt =>
      'Добро пожаловать! 🌍 Прежде чем начать, выберите предпочтительный язык:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Совет:** Вы можете изменить язык в любое время, спросив \'какие языки доступны?\' или сказав \'сменить на [язык]\'.';

  @override
  String get profilePhotoTitle => 'Фото профиля';

  @override
  String get profilePhotoRealTab => 'Настоящее фото';

  @override
  String get profilePhotoAvatarTab => 'Аватар';

  @override
  String get profilePhotoCamera => 'Камера';

  @override
  String get profilePhotoGallery => 'Галерея';

  @override
  String get profilePhotoHint => 'Выберите фото или выберите аватар ниже';

  @override
  String get profilePhotoPrompt =>
      'Теперь давайте персонализируем ваш профиль! 📸 Вы можете загрузить настоящее фото или выбрать один из наших забавных аватаров:';

  @override
  String get profilePhotoConfirmation =>
      'Отличный выбор! Ваш профиль выглядит отлично! 😊';

  @override
  String get profilePhotoTip =>
      '💡 **Совет:** Вы можете изменить фото в любое время, сказав \'изменить мое фото\' или \'изменить мой аватар\'.';

  @override
  String get profilePhotoChangeRequest =>
      'Конечно! Позвольте показать вам варианты обновления фото профиля:';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
