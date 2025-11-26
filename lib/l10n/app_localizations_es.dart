// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get loadingText => 'Cargando...';

  @override
  String get onboardingWelcomeMessage =>
      '¡Hola! 👋 ¡Bienvenido a FEEDLOG! Soy tu asistente de nutrición con inteligencia artificial, ¡y estoy emocionado de ayudarte a alcanzar tus objetivos de salud!\n\nAhora vamos a completar tu registro para poder ofrecerte el mejor seguimiento posible.|||¿Cómo te gustaría que te llame?';

  @override
  String onboardingNameConfirmation(String name) {
    return '¡Encantado de conocerte, $name! 😊 Ahora necesito saber tu sexo biológico para calcular tu perfil nutricional con precisión.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return '¡Perfecto, $name! 😊 Para calcular tu perfil nutricional con precisión, necesito saber tu sexo biológico. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt =>
      '¡Genial! Ahora dime: ¿cuántos años tienes?';

  @override
  String get onboardingHeightPrompt =>
      '¡Perfecto! ¿Y cuál es tu altura? (puede ser en metros o centímetros)';

  @override
  String get onboardingWeightPrompt =>
      '¡Entendido! Ahora cuéntame: ¿cuál es tu peso actual?';

  @override
  String get onboardingTargetWeightPrompt =>
      '¡Anotado! ¿Y cuál es tu peso objetivo? (el peso que quieres alcanzar)';

  @override
  String get onboardingActivityPrompt =>
      'Para calcular tu gasto calórico, necesito saber: ¿cuál es tu nivel de actividad física diaria?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      '¡Genial! Última pregunta: ¿cuál es tu objetivo principal?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 ¡Registro completo, $name!\n\nHe calculado tu perfil nutricional:\n• TDEE: $tdee kcal/día\n• Meta diaria: $dailyCalories kcal\n• Proteína: ${protein}g\n• Carbohidratos: ${carbs}g\n• Grasa: ${fat}g\n\n¡Ahora te enseñaré cómo usar FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 Cómo funciona FEEDLOG:\n\n1️⃣ **Registrar comidas**: ¡Solo cuéntame lo que comiste! Ejemplo: \'Comí 2 huevos y una banana\'\n\n2️⃣ **Ver tu progreso**: Pregunta \'¿Cuántas calorías comí hoy?\' o \'¿Cómo va mi día?\'\n\n3️⃣ **Actualizar peso**: Di \'Perdí 1kg\' o \'Estoy en 80kg\'\n\n4️⃣ **Consultar alimentos**: Pregunta \'¿Cuántas calorías tiene una manzana?\'\n\n¡Todo funciona conversando conmigo naturalmente! ¿Listos para comenzar? 🚀';

  @override
  String get chatWelcomeBack => '¡Bienvenido de vuelta! ¿Qué comiste hoy?';

  @override
  String get chatNameError =>
      'Lo siento, no pude identificar tu nombre. ¿Podrías escribir solo cómo quieres que te llame?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age años, ¡anotado! ✅';
  }

  @override
  String get chatAgeError => 'Por favor, ingresa una edad válida (ej: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m de altura, ¡genial! ✅';
  }

  @override
  String get chatHeightError =>
      'No entendí la altura. Intenta algo como \'1.75\' o \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '¡${weight}kg registrado! ✅';
  }

  @override
  String get chatWeightError =>
      'No entendí el peso. Intenta algo como \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return '¡Meta de ${weight}kg definida! 💪';
  }

  @override
  String get chatTargetWeightError =>
      '¿Cuál es tu peso objetivo? Ej: \'70kg\'.';

  @override
  String get chatSelectOptionAbove =>
      'Por favor, selecciona una opción arriba.';

  @override
  String get chatGenderConfirmation => '¡Anotado! ✅';

  @override
  String get chatActivityConfirmation => '¡Perfecto! 💪';

  @override
  String get chatLogoutConfirmation =>
      '¡Entendido! Cerrando sesión... ¡Hasta luego! 👋';

  @override
  String get chatProcessingError =>
      'Lo siento, tuve un problema al procesar tu mensaje. Inténtalo de nuevo.';

  @override
  String get chatImageAnalyzing => 'Analizando tu imagen... 📸';

  @override
  String get chatDailySummaryDefault => 'Aquí está tu resumen diario:';

  @override
  String get chatInputPlaceholder => 'Escribe tu mensaje...';

  @override
  String get loginTagline => 'Tu asistente nutricional con IA';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Contraseña';

  @override
  String get loginEmailRequired => 'Ingresa tu email';

  @override
  String get loginEmailInvalid => 'Email inválido';

  @override
  String get loginPasswordRequired => 'Ingresa tu contraseña';

  @override
  String get loginPasswordLengthError =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get loginSignupLink => '¿No tienes cuenta? Regístrate';

  @override
  String get signupTitle => 'Crear Cuenta';

  @override
  String get signupSubtitle => 'Únete a FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Confirmar Contraseña';

  @override
  String get signupConfirmPasswordRequired => 'Confirma tu contraseña';

  @override
  String get signupPasswordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get signupTermsAcceptance =>
      'Acepto los términos de uso y política de privacidad';

  @override
  String get signupTermsRequired => 'Debes aceptar los términos para continuar';

  @override
  String get signupButton => 'Crear Cuenta';

  @override
  String get signupLoginLink => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get loadingVerification => 'Verificando sesión...';

  @override
  String get genderSelectorTitle => 'Selecciona tu Sexo Biológico';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Femenino';

  @override
  String get activitySelectorTitle => 'Nivel de Actividad Física';

  @override
  String get activitySedentary => 'Sedentario';

  @override
  String get activitySedentaryDesc => 'Poco o ningún ejercicio';

  @override
  String get activityLight => 'Ligero';

  @override
  String get activityLightDesc => 'Ejercicio ligero 1-3 días/semana';

  @override
  String get activityModerate => 'Moderado';

  @override
  String get activityModerateDesc => 'Ejercicio moderado 3-5 días/semana';

  @override
  String get activityHeavy => 'Pesado';

  @override
  String get activityHeavyDesc => 'Ejercicio intenso 6-7 días/semana';

  @override
  String get activityAthlete => 'Atleta';

  @override
  String get activityAthleteDesc => 'Ejercicio muy intenso, trabajo físico';

  @override
  String get goalSelectorTitle => 'Tu Objetivo Principal';

  @override
  String get goalLose => 'Perder Peso';

  @override
  String get goalLoseDesc => 'Déficit calórico de 500 kcal/día';

  @override
  String get goalMaintain => 'Mantener Peso';

  @override
  String get goalMaintainDesc => 'Dieta de mantenimiento';

  @override
  String get goalGain => 'Ganar Masa';

  @override
  String get goalGainDesc => 'Superávit calórico de 300 kcal/día';

  @override
  String get dailySummaryTitle => 'Resumen Diario';

  @override
  String get dailySummaryCalories => 'Calorías';

  @override
  String get dailySummaryProtein => 'Proteína';

  @override
  String get dailySummaryCarbs => 'Carbohidratos';

  @override
  String get dailySummaryFat => 'Grasa';

  @override
  String get dailySummaryLeft => 'Restante';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'Este idioma aún no está disponible en FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Idiomas disponibles';

  @override
  String get languageChangePrompt => '¿Te gustaría elegir un idioma diferente?';

  @override
  String get languageChangeConfirm => '¡Idioma cambiado con éxito! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Este idioma no está disponible. Idiomas disponibles: $languages';
  }

  @override
  String languageChanged(String language) {
    return '¡Idioma cambiado a $language! 🌍 A partir de ahora responderé en este idioma.';
  }

  @override
  String get languageSelectorTitle => 'Seleccionar Idioma';

  @override
  String get languageSelectorPrompt =>
      'Aquí están los idiomas disponibles. Selecciona el que prefieras:';

  @override
  String get onboardingLanguagePrompt =>
      '¡Bienvenido! 🌍 Antes de comenzar, selecciona tu idioma preferido:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Consejo:** Puedes cambiar el idioma en cualquier momento preguntando \'¿qué idiomas hay disponibles?\' o diciendo \'cambiar a [idioma]\'.';
}
