// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get loadingText => 'Chargement...';

  @override
  String get onboardingWelcomeMessage =>
      'Bonjour ! 👋 Bienvenue sur FEEDLOG ! Je suis votre assistant nutrition alimenté par l\'intelligence artificielle, et je suis ravi de vous aider à atteindre vos objectifs de santé !\n\nComplétons maintenant votre profil pour que je puisse vous offrir le meilleur suivi possible.|||Comment aimeriez-vous être appelé ?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Ravi de vous rencontrer, $name ! 😊 Maintenant, j\'ai besoin de connaître votre sexe biologique pour calculer votre profil nutritionnel avec précision.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Parfait, $name ! 😊 Pour calculer votre profil nutritionnel avec précision, j\'ai besoin de connaître votre sexe biologique. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt =>
      'Génial ! Maintenant dites-moi : quel âge avez-vous ?';

  @override
  String get onboardingHeightPrompt =>
      'Parfait ! Et quelle est votre taille ? (en mètres ou centimètres)';

  @override
  String get onboardingWeightPrompt =>
      'Compris ! Maintenant dites-moi : quel est votre poids actuel ?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Noté ! Et quel est votre poids cible ? (le poids que vous souhaitez atteindre)';

  @override
  String get onboardingActivityPrompt =>
      'Pour calculer votre dépense calorique, j\'ai besoin de savoir : quel est votre niveau d\'activité physique quotidien ?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Génial ! Dernière question : quel est votre objectif principal ?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Profil complet, $name !\n\nJ\'ai calculé votre profil nutritionnel :\n• TDEE : $tdee kcal/jour\n• Objectif quotidien : $dailyCalories kcal\n• Protéines : ${protein}g\n• Glucides : ${carbs}g\n• Lipides : ${fat}g\n\nMaintenant, je vais vous montrer comment utiliser FEEDLOG !';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 Comment fonctionne FEEDLOG :\n\n1️⃣ **Enregistrer les repas** : Dites-moi simplement ce que vous avez mangé ! Exemple : \'J\'ai mangé 2 œufs et une banane\'\n\n2️⃣ **Voir vos progrès** : Demandez \'Combien de calories ai-je mangé aujourd\'hui ?\' ou \'Comment va ma journée ?\'\n\n3️⃣ **Mettre à jour le poids** : Dites \'J\'ai perdu 1kg\' ou \'Je pèse 80kg\'\n\n4️⃣ **Consulter les aliments** : Demandez \'Combien de calories dans une pomme ?\'\n\nTout fonctionne en discutant naturellement avec moi ! Prêt à commencer ? 🚀';

  @override
  String get chatWelcomeBack =>
      'Bon retour ! Qu\'avez-vous mangé aujourd\'hui ?';

  @override
  String get chatNameError =>
      'Désolé, je n\'ai pas pu identifier votre nom. Pourriez-vous simplement écrire comment vous souhaitez être appelé ?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age ans, noté ! ✅';
  }

  @override
  String get chatAgeError => 'Veuillez entrer un âge valide (ex : 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m, génial ! ✅';
  }

  @override
  String get chatHeightError =>
      'Je n\'ai pas compris la taille. Essayez quelque chose comme \'1.75\' ou \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg enregistré ! ✅';
  }

  @override
  String get chatWeightError =>
      'Je n\'ai pas compris le poids. Essayez quelque chose comme \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Objectif de ${weight}kg défini ! 💪';
  }

  @override
  String get chatTargetWeightError =>
      'Quel est votre poids cible ? Ex : \'70kg\'.';

  @override
  String get chatSelectOptionAbove =>
      'Veuillez sélectionner une option ci-dessus.';

  @override
  String get chatGenderConfirmation => 'Noté ! ✅';

  @override
  String get chatActivityConfirmation => 'Parfait ! 💪';

  @override
  String get chatLogoutConfirmation =>
      'Compris ! Déconnexion... À bientôt ! 👋';

  @override
  String get chatProcessingError =>
      'Désolé, j\'ai eu un problème lors du traitement de votre message. Veuillez réessayer.';

  @override
  String get chatImageAnalyzing => 'Analyse de votre image... 📸';

  @override
  String get chatDailySummaryDefault => 'Voici votre résumé quotidien :';

  @override
  String get chatInputPlaceholder => 'Tapez votre message...';

  @override
  String get loginTagline => 'Votre assistant nutritionnel IA';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Mot de passe';

  @override
  String get loginEmailRequired => 'Entrez votre email';

  @override
  String get loginEmailInvalid => 'Email invalide';

  @override
  String get loginPasswordRequired => 'Entrez votre mot de passe';

  @override
  String get loginPasswordLengthError =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get loginButton => 'Connexion';

  @override
  String get loginSignupLink => 'Pas de compte ? Inscrivez-vous';

  @override
  String get signupTitle => 'Créer un Compte';

  @override
  String get signupSubtitle => 'Rejoignez FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Confirmer le Mot de Passe';

  @override
  String get signupConfirmPasswordRequired => 'Confirmez votre mot de passe';

  @override
  String get signupPasswordsMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get signupTermsAcceptance =>
      'J\'accepte les conditions d\'utilisation et la politique de confidentialité';

  @override
  String get signupTermsRequired =>
      'Vous devez accepter les conditions pour continuer';

  @override
  String get signupButton => 'Créer un Compte';

  @override
  String get signupLoginLink => 'Déjà un compte ? Connectez-vous';

  @override
  String get loadingVerification => 'Vérification de la connexion...';

  @override
  String get genderSelectorTitle => 'Sélectionnez Votre Sexe Biologique';

  @override
  String get genderMale => 'Masculin';

  @override
  String get genderFemale => 'Féminin';

  @override
  String get activitySelectorTitle => 'Niveau d\'Activité Physique';

  @override
  String get activitySedentary => 'Sédentaire';

  @override
  String get activitySedentaryDesc => 'Peu ou pas d\'exercice';

  @override
  String get activityLight => 'Léger';

  @override
  String get activityLightDesc => 'Exercice léger 1-3 jours/semaine';

  @override
  String get activityModerate => 'Modéré';

  @override
  String get activityModerateDesc => 'Exercice modéré 3-5 jours/semaine';

  @override
  String get activityHeavy => 'Intense';

  @override
  String get activityHeavyDesc => 'Exercice intense 6-7 jours/semaine';

  @override
  String get activityAthlete => 'Athlète';

  @override
  String get activityAthleteDesc => 'Exercice très intense, travail physique';

  @override
  String get goalSelectorTitle => 'Votre Objectif Principal';

  @override
  String get goalLose => 'Perdre du Poids';

  @override
  String get goalLoseDesc => 'Déficit calorique de 500 kcal/jour';

  @override
  String get goalMaintain => 'Maintenir le Poids';

  @override
  String get goalMaintainDesc => 'Régime de maintien';

  @override
  String get goalGain => 'Prendre de la Masse';

  @override
  String get goalGainDesc => 'Surplus calorique de 300 kcal/jour';

  @override
  String get dailySummaryTitle => 'Résumé Quotidien';

  @override
  String get dailySummaryCalories => 'Calories';

  @override
  String get dailySummaryProtein => 'Protéines';

  @override
  String get dailySummaryCarbs => 'Glucides';

  @override
  String get dailySummaryFat => 'Lipides';

  @override
  String get dailySummaryLeft => 'Restant';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'Cette langue n\'est pas encore disponible dans FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Langues disponibles';

  @override
  String get languageChangePrompt =>
      'Souhaitez-vous choisir une autre langue ?';

  @override
  String get languageChangeConfirm => 'Langue changée avec succès ! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Cette langue n\'est pas disponible. Langues disponibles : $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Langue changée en $language ! 🌍 Désormais je répondrai dans cette langue.';
  }

  @override
  String get languageSelectorTitle => 'Sélectionner la Langue';

  @override
  String get languageSelectorPrompt =>
      'Voici les langues disponibles. Sélectionnez celle que vous préférez :';

  @override
  String get onboardingLanguagePrompt =>
      'Bienvenue ! 🌍 Avant de commencer, sélectionnez votre langue préférée :';

  @override
  String get onboardingLanguageTip =>
      '💡 **Astuce :** Vous pouvez changer la langue à tout moment en demandant \'quelles langues sont disponibles ?\' ou en disant \'changer en [langue]\'.';
}
