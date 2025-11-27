// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Conferma';

  @override
  String get loadingText => 'Caricamento...';

  @override
  String get onboardingWelcomeMessage =>
      'Ciao! 👋 Benvenuto su FEEDLOG! Sono il tuo assistente nutrizionale con intelligenza artificiale, e sono entusiasta di aiutarti a raggiungere i tuoi obiettivi di salute!\n\nOra completiamo il tuo profilo così posso offrirti il miglior supporto possibile.|||Come vorresti essere chiamato?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Piacere di conoscerti, $name! 😊 Ora ho bisogno di sapere il tuo sesso biologico per calcolare il tuo profilo nutrizionale con precisione.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Perfetto, $name! 😊 Per calcolare il tuo profilo nutrizionale con precisione, ho bisogno di sapere il tuo sesso biologico. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => 'Ottimo! Ora dimmi: quanti anni hai?';

  @override
  String get onboardingHeightPrompt =>
      'Perfetto! E qual è la tua altezza? (in metri o centimetri)';

  @override
  String get onboardingWeightPrompt =>
      'Capito! Ora dimmi: qual è il tuo peso attuale?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Annotato! E qual è il tuo peso obiettivo? (il peso che vuoi raggiungere)';

  @override
  String get onboardingActivityPrompt =>
      'Per calcolare il tuo dispendio calorico, ho bisogno di sapere: qual è il tuo livello di attività fisica quotidiano?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Ottimo! Ultima domanda: qual è il tuo obiettivo principale?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Profilo completo, $name!\n\nHo calcolato il tuo profilo nutrizionale:\n• TDEE: $tdee kcal/giorno\n• Obiettivo giornaliero: $dailyCalories kcal\n• Proteine: ${protein}g\n• Carboidrati: ${carbs}g\n• Grassi: ${fat}g\n\nOra ti mostro come usare FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 Come funziona FEEDLOG:\n\n1️⃣ **Registrare pasti**: Dimmi semplicemente cosa hai mangiato! Esempio: \'Ho mangiato 2 uova e una banana\'\n\n2️⃣ **Vedere i progressi**: Chiedi \'Quante calorie ho mangiato oggi?\' o \'Come va la mia giornata?\'\n\n3️⃣ **Aggiornare peso**: Di\' \'Ho perso 1kg\' o \'Peso 80kg\'\n\n4️⃣ **Consultare alimenti**: Chiedi \'Quante calorie ha una mela?\'\n\nTutto funziona chattando naturalmente con me! Pronti a iniziare? 🚀';

  @override
  String get chatWelcomeBack => 'Bentornato! Cosa hai mangiato oggi?';

  @override
  String get chatNameError =>
      'Scusa, non sono riuscito a identificare il tuo nome. Potresti scrivere semplicemente come vuoi essere chiamato?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age anni, annotato! ✅';
  }

  @override
  String get chatAgeError => 'Per favore, inserisci un\'età valida (es: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m di altezza, ottimo! ✅';
  }

  @override
  String get chatHeightError =>
      'Non ho capito l\'altezza. Prova qualcosa come \'1.75\' o \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg registrato! ✅';
  }

  @override
  String get chatWeightError =>
      'Non ho capito il peso. Prova qualcosa come \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Obiettivo di ${weight}kg impostato! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'Qual è il tuo peso obiettivo? Es: \'70kg\'.';

  @override
  String get chatSelectOptionAbove =>
      'Per favore, seleziona un\'opzione sopra.';

  @override
  String get chatGenderConfirmation => 'Annotato! ✅';

  @override
  String get chatActivityConfirmation => 'Perfetto! 💪';

  @override
  String get chatLogoutConfirmation =>
      'Capito! Disconnessione in corso... A presto! 👋';

  @override
  String get chatProcessingError =>
      'Scusa, ho avuto un problema nell\'elaborare il tuo messaggio. Riprova.';

  @override
  String get chatImageAnalyzing => 'Analizzando la tua immagine... 📸';

  @override
  String get chatDailySummaryDefault => 'Ecco il tuo riepilogo giornaliero:';

  @override
  String get chatInputPlaceholder => 'Scrivi il tuo messaggio...';

  @override
  String get loginTagline => 'Il tuo assistente nutrizionale IA';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Password';

  @override
  String get loginEmailRequired => 'Inserisci la tua email';

  @override
  String get loginEmailInvalid => 'Email non valida';

  @override
  String get loginPasswordRequired => 'Inserisci la tua password';

  @override
  String get loginPasswordLengthError =>
      'La password deve avere almeno 6 caratteri';

  @override
  String get loginButton => 'Accedi';

  @override
  String get loginSignupLink => 'Non hai un account? Registrati';

  @override
  String get signupTitle => 'Crea Account';

  @override
  String get signupSubtitle => 'Unisciti a FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Conferma Password';

  @override
  String get signupConfirmPasswordRequired => 'Conferma la tua password';

  @override
  String get signupPasswordsMismatch => 'Le password non corrispondono';

  @override
  String get signupTermsAcceptance =>
      'Accetto i termini d\'uso e la privacy policy';

  @override
  String get signupTermsRequired => 'Devi accettare i termini per continuare';

  @override
  String get signupButton => 'Crea Account';

  @override
  String get signupLoginLink => 'Hai già un account? Accedi';

  @override
  String get loadingVerification => 'Verifica accesso...';

  @override
  String get genderSelectorTitle => 'Seleziona il Tuo Sesso Biologico';

  @override
  String get genderMale => 'Maschile';

  @override
  String get genderFemale => 'Femminile';

  @override
  String get activitySelectorTitle => 'Livello di Attività Fisica';

  @override
  String get activitySedentary => 'Sedentario';

  @override
  String get activitySedentaryDesc => 'Poco o nessun esercizio';

  @override
  String get activityLight => 'Leggero';

  @override
  String get activityLightDesc => 'Esercizio leggero 1-3 giorni/settimana';

  @override
  String get activityModerate => 'Moderato';

  @override
  String get activityModerateDesc => 'Esercizio moderato 3-5 giorni/settimana';

  @override
  String get activityHeavy => 'Intenso';

  @override
  String get activityHeavyDesc => 'Esercizio intenso 6-7 giorni/settimana';

  @override
  String get activityAthlete => 'Atleta';

  @override
  String get activityAthleteDesc => 'Esercizio molto intenso, lavoro fisico';

  @override
  String get goalSelectorTitle => 'Il Tuo Obiettivo Principale';

  @override
  String get goalLose => 'Perdere Peso';

  @override
  String get goalLoseDesc => 'Deficit calorico di 500 kcal/giorno';

  @override
  String get goalMaintain => 'Mantenere Peso';

  @override
  String get goalMaintainDesc => 'Dieta di mantenimento';

  @override
  String get goalGain => 'Aumentare Massa';

  @override
  String get goalGainDesc => 'Surplus calorico di 300 kcal/giorno';

  @override
  String get dailySummaryTitle => 'Riepilogo Giornaliero';

  @override
  String get dailySummaryCalories => 'Calorie';

  @override
  String get dailySummaryProtein => 'Proteine';

  @override
  String get dailySummaryCarbs => 'Carboidrati';

  @override
  String get dailySummaryFat => 'Grassi';

  @override
  String get dailySummaryLeft => 'Rimanenti';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'Questa lingua non è ancora disponibile in FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Lingue disponibili';

  @override
  String get languageChangePrompt => 'Vorresti scegliere una lingua diversa?';

  @override
  String get languageChangeConfirm => 'Lingua cambiata con successo! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Questa lingua non è disponibile. Lingue disponibili: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Lingua cambiata in $language! 🌍 D\'ora in poi risponderò in questa lingua.';
  }

  @override
  String get languageSelectorTitle => 'Seleziona Lingua';

  @override
  String get languageSelectorPrompt =>
      'Ecco le lingue disponibili. Seleziona quella che preferisci:';

  @override
  String get onboardingLanguagePrompt =>
      'Benvenuto! 🌍 Prima di iniziare, seleziona la tua lingua preferita:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Suggerimento:** Puoi cambiare la lingua in qualsiasi momento chiedendo \'quali lingue sono disponibili?\' o dicendo \'cambia in [lingua]\'.';

  @override
  String get profilePhotoTitle => 'Foto Profilo';

  @override
  String get profilePhotoRealTab => 'Foto Reale';

  @override
  String get profilePhotoAvatarTab => 'Avatar';

  @override
  String get profilePhotoCamera => 'Fotocamera';

  @override
  String get profilePhotoGallery => 'Galleria';

  @override
  String get profilePhotoHint =>
      'Scegli una foto o seleziona un avatar qui sotto';

  @override
  String get profilePhotoPrompt =>
      'Ora personalizziamo il tuo profilo! 📸 Puoi caricare una foto reale o scegliere uno dei nostri divertenti avatar:';

  @override
  String get profilePhotoConfirmation =>
      'Ottima scelta! Il tuo profilo sta benissimo! 😊';

  @override
  String get profilePhotoTip =>
      '💡 **Suggerimento:** Puoi cambiare la tua foto in qualsiasi momento dicendo \'cambia la mia foto\' o \'cambia il mio avatar\'.';

  @override
  String get profilePhotoChangeRequest =>
      'Certo! Lasciami mostrarti le opzioni per aggiornare la tua foto profilo:';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
