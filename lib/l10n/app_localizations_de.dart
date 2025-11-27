// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Bestätigen';

  @override
  String get loadingText => 'Laden...';

  @override
  String get onboardingWelcomeMessage =>
      'Hallo! 👋 Willkommen bei FEEDLOG! Ich bin dein KI-gestützter Ernährungsassistent und freue mich, dir bei deinen Gesundheitszielen zu helfen!\n\nLass uns jetzt dein Profil vervollständigen, damit ich dir die bestmögliche Unterstützung bieten kann.|||Wie möchtest du genannt werden?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Freut mich, dich kennenzulernen, $name! 😊 Jetzt brauche ich dein biologisches Geschlecht, um dein Ernährungsprofil genau zu berechnen.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Perfekt, $name! 😊 Um dein Ernährungsprofil genau zu berechnen, muss ich dein biologisches Geschlecht wissen. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => 'Toll! Jetzt sag mir: wie alt bist du?';

  @override
  String get onboardingHeightPrompt =>
      'Perfekt! Und wie groß bist du? (in Metern oder Zentimetern)';

  @override
  String get onboardingWeightPrompt =>
      'Verstanden! Jetzt sag mir: wie viel wiegst du aktuell?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Notiert! Und was ist dein Zielgewicht? (das Gewicht, das du erreichen möchtest)';

  @override
  String get onboardingActivityPrompt =>
      'Um deinen Kalorienverbrauch zu berechnen, muss ich wissen: wie ist dein tägliches Aktivitätsniveau?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Toll! Letzte Frage: was ist dein Hauptziel?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Profil vollständig, $name!\n\nIch habe dein Ernährungsprofil berechnet:\n• TDEE: $tdee kcal/Tag\n• Tagesziel: $dailyCalories kcal\n• Protein: ${protein}g\n• Kohlenhydrate: ${carbs}g\n• Fett: ${fat}g\n\nJetzt zeige ich dir, wie FEEDLOG funktioniert!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 So funktioniert FEEDLOG:\n\n1️⃣ **Mahlzeiten erfassen**: Erzähl mir einfach, was du gegessen hast! Beispiel: \'Ich habe 2 Eier und eine Banane gegessen\'\n\n2️⃣ **Fortschritt sehen**: Frag \'Wie viele Kalorien habe ich heute gegessen?\' oder \'Wie läuft mein Tag?\'\n\n3️⃣ **Gewicht aktualisieren**: Sag \'Ich habe 1kg abgenommen\' oder \'Ich wiege 80kg\'\n\n4️⃣ **Lebensmittel prüfen**: Frag \'Wie viele Kalorien hat ein Apfel?\'\n\nAlles funktioniert durch natürliches Chatten mit mir! Bereit loszulegen? 🚀';

  @override
  String get chatWelcomeBack =>
      'Willkommen zurück! Was hast du heute gegessen?';

  @override
  String get chatNameError =>
      'Entschuldigung, ich konnte deinen Namen nicht erkennen. Könntest du einfach schreiben, wie du genannt werden möchtest?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age Jahre alt, notiert! ✅';
  }

  @override
  String get chatAgeError => 'Bitte gib ein gültiges Alter ein (z.B. 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m groß, toll! ✅';
  }

  @override
  String get chatHeightError =>
      'Die Größe habe ich nicht verstanden. Versuche etwas wie \'1.75\' oder \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg registriert! ✅';
  }

  @override
  String get chatWeightError =>
      'Das Gewicht habe ich nicht verstanden. Versuche etwas wie \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Ziel von ${weight}kg gesetzt! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'Was ist dein Zielgewicht? Z.B. \'70kg\'.';

  @override
  String get chatSelectOptionAbove => 'Bitte wähle eine Option oben aus.';

  @override
  String get chatGenderConfirmation => 'Notiert! ✅';

  @override
  String get chatActivityConfirmation => 'Perfekt! 💪';

  @override
  String get chatLogoutConfirmation =>
      'Verstanden! Abmeldung läuft... Bis bald! 👋';

  @override
  String get chatProcessingError =>
      'Entschuldigung, ich hatte ein Problem bei der Verarbeitung deiner Nachricht. Bitte versuche es erneut.';

  @override
  String get chatImageAnalyzing => 'Analysiere dein Bild... 📸';

  @override
  String get chatDailySummaryDefault => 'Hier ist deine Tageszusammenfassung:';

  @override
  String get chatInputPlaceholder => 'Nachricht eingeben...';

  @override
  String get loginTagline => 'Dein KI-Ernährungsassistent';

  @override
  String get loginEmailPlaceholder => 'E-Mail';

  @override
  String get loginPasswordPlaceholder => 'Passwort';

  @override
  String get loginEmailRequired => 'Gib deine E-Mail ein';

  @override
  String get loginEmailInvalid => 'Ungültige E-Mail';

  @override
  String get loginPasswordRequired => 'Gib dein Passwort ein';

  @override
  String get loginPasswordLengthError =>
      'Passwort muss mindestens 6 Zeichen haben';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get loginSignupLink => 'Kein Konto? Registrieren';

  @override
  String get signupTitle => 'Konto Erstellen';

  @override
  String get signupSubtitle => 'FEEDLOG beitreten';

  @override
  String get signupConfirmPasswordPlaceholder => 'Passwort Bestätigen';

  @override
  String get signupConfirmPasswordRequired => 'Bestätige dein Passwort';

  @override
  String get signupPasswordsMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get signupTermsAcceptance =>
      'Ich akzeptiere die Nutzungsbedingungen und Datenschutzrichtlinie';

  @override
  String get signupTermsRequired =>
      'Du musst die Bedingungen akzeptieren um fortzufahren';

  @override
  String get signupButton => 'Konto Erstellen';

  @override
  String get signupLoginLink => 'Bereits ein Konto? Anmelden';

  @override
  String get loadingVerification => 'Anmeldung wird überprüft...';

  @override
  String get genderSelectorTitle => 'Wähle Dein Biologisches Geschlecht';

  @override
  String get genderMale => 'Männlich';

  @override
  String get genderFemale => 'Weiblich';

  @override
  String get activitySelectorTitle => 'Körperliches Aktivitätsniveau';

  @override
  String get activitySedentary => 'Sitzend';

  @override
  String get activitySedentaryDesc => 'Wenig oder kein Sport';

  @override
  String get activityLight => 'Leicht';

  @override
  String get activityLightDesc => 'Leichter Sport 1-3 Tage/Woche';

  @override
  String get activityModerate => 'Moderat';

  @override
  String get activityModerateDesc => 'Moderater Sport 3-5 Tage/Woche';

  @override
  String get activityHeavy => 'Intensiv';

  @override
  String get activityHeavyDesc => 'Intensiver Sport 6-7 Tage/Woche';

  @override
  String get activityAthlete => 'Athlet';

  @override
  String get activityAthleteDesc => 'Sehr intensiver Sport, körperliche Arbeit';

  @override
  String get goalSelectorTitle => 'Dein Hauptziel';

  @override
  String get goalLose => 'Abnehmen';

  @override
  String get goalLoseDesc => 'Kaloriendefizit von 500 kcal/Tag';

  @override
  String get goalMaintain => 'Gewicht Halten';

  @override
  String get goalMaintainDesc => 'Erhaltungsdiät';

  @override
  String get goalGain => 'Muskeln Aufbauen';

  @override
  String get goalGainDesc => 'Kalorienüberschuss von 300 kcal/Tag';

  @override
  String get dailySummaryTitle => 'Tageszusammenfassung';

  @override
  String get dailySummaryCalories => 'Kalorien';

  @override
  String get dailySummaryProtein => 'Protein';

  @override
  String get dailySummaryCarbs => 'Kohlenhydrate';

  @override
  String get dailySummaryFat => 'Fett';

  @override
  String get dailySummaryLeft => 'Übrig';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'Diese Sprache ist noch nicht in FEEDLOG verfügbar.';

  @override
  String get languageAvailableOptions => 'Verfügbare Sprachen';

  @override
  String get languageChangePrompt => 'Möchtest du eine andere Sprache wählen?';

  @override
  String get languageChangeConfirm => 'Sprache erfolgreich geändert! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Diese Sprache ist nicht verfügbar. Verfügbare Sprachen: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Sprache auf $language geändert! 🌍 Ab jetzt werde ich in dieser Sprache antworten.';
  }

  @override
  String get languageSelectorTitle => 'Sprache Auswählen';

  @override
  String get languageSelectorPrompt =>
      'Hier sind die verfügbaren Sprachen. Wähle die gewünschte aus:';

  @override
  String get onboardingLanguagePrompt =>
      'Willkommen! 🌍 Bevor wir beginnen, wähle bitte deine bevorzugte Sprache:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Tipp:** Du kannst die Sprache jederzeit ändern, indem du fragst \'welche Sprachen sind verfügbar?\' oder sagst \'auf [Sprache] wechseln\'.';

  @override
  String get profilePhotoTitle => 'Profilfoto';

  @override
  String get profilePhotoRealTab => 'Echtes Foto';

  @override
  String get profilePhotoAvatarTab => 'Avatar';

  @override
  String get profilePhotoCamera => 'Kamera';

  @override
  String get profilePhotoGallery => 'Galerie';

  @override
  String get profilePhotoHint => 'Wähle ein Foto oder wähle unten einen Avatar';

  @override
  String get profilePhotoPrompt =>
      'Jetzt personalisieren wir dein Profil! 📸 Du kannst ein echtes Foto hochladen oder einen unserer lustigen Avatare wählen:';

  @override
  String get profilePhotoConfirmation =>
      'Tolle Wahl! Dein Profil sieht super aus! 😊';

  @override
  String get profilePhotoTip =>
      '💡 **Tipp:** Du kannst dein Foto jederzeit ändern, indem du sagst \'mein Foto ändern\' oder \'meinen Avatar ändern\'.';

  @override
  String get profilePhotoChangeRequest =>
      'Klar! Lass mich dir die Optionen zeigen, um dein Profilfoto zu aktualisieren:';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
