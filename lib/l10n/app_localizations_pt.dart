// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get loadingText => 'Carregando...';

  @override
  String get onboardingWelcomeMessage =>
      'Olá! 👋 Seja muito bem-vindo ao FEEDLOG! Eu sou seu assistente de nutrição com inteligência artificial, e estou muito animado para te ajudar a alcançar seus objetivos de saúde!\n\nA partir de agora, vamos completar seu cadastro para que eu possa te oferecer o melhor acompanhamento possível.|||Como você gostaria de ser chamado?';

  @override
  String onboardingNameConfirmation(String name) {
    return 'Prazer em te conhecer, $name! 😊 Agora preciso saber seu sexo biológico para calcular seu perfil nutricional com precisão.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return 'Perfeito, $name! 😊 Para calcular seu perfil nutricional com precisão, preciso saber seu sexo biológico. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt =>
      'Ótimo! Agora me diz: quantos anos você tem?';

  @override
  String get onboardingHeightPrompt =>
      'Perfeito! E qual é sua altura? (pode ser em metros ou centímetros)';

  @override
  String get onboardingWeightPrompt =>
      'Entendi! Agora me conta: qual é seu peso atual?';

  @override
  String get onboardingTargetWeightPrompt =>
      'Anotado! E qual é seu peso alvo? (o peso que você quer atingir)';

  @override
  String get onboardingActivityPrompt =>
      'Para calcular seu gasto calórico, preciso saber: como é seu nível de atividade física no dia a dia?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      'Ótimo! Última pergunta: qual é seu objetivo principal?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 Cadastro completo, $name!\n\nCalculei seu perfil nutricional:\n• TDEE: $tdee kcal/dia\n• Meta diária: $dailyCalories kcal\n• Proteína: ${protein}g\n• Carboidratos: ${carbs}g\n• Gordura: ${fat}g\n\nAgora vou te ensinar como usar o FEEDLOG!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 Como funciona o FEEDLOG:\n\n1️⃣ **Registrar refeições**: Basta me contar o que comeu! Exemplo: \'Comi 2 ovos e uma banana\'\n\n2️⃣ **Ver seu progresso**: Pergunte \'Quantas calorias comi hoje?\' ou \'Como está meu dia?\'\n\n3️⃣ **Atualizar peso**: Diga \'Perdi 1kg\' ou \'Estou com 80kg\'\n\n4️⃣ **Consultar alimentos**: Pergunte \'Quantas calorias tem uma maçã?\'\n\nTudo funciona conversando comigo naturalmente! Estamos prontos para começar? 🚀';

  @override
  String get chatWelcomeBack => 'Bem-vindo de volta! O que você comeu hoje?';

  @override
  String get chatNameError =>
      'Desculpe, não consegui identificar seu nome. Poderia digitar apenas como quer ser chamado?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age anos, anotado! ✅';
  }

  @override
  String get chatAgeError => 'Por favor, digite uma idade válida (ex: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m de altura, ótimo! ✅';
  }

  @override
  String get chatHeightError =>
      'Não entendi a altura. Tente algo como \'1.75\' ou \'175cm\'.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg registrado! ✅';
  }

  @override
  String get chatWeightError => 'Não entendi o peso. Tente algo como \'80kg\'.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return 'Meta de ${weight}kg definida! 💪';
  }

  @override
  String get chatTargetWeightError => 'Qual é seu peso alvo? Ex: \'70kg\'.';

  @override
  String get chatSelectOptionAbove => 'Por favor, selecione uma opção acima.';

  @override
  String get chatGenderConfirmation => 'Anotado! ✅';

  @override
  String get chatActivityConfirmation => 'Perfeito! 💪';

  @override
  String get chatLogoutConfirmation =>
      'Entendido! Fazendo logout... Até logo! 👋';

  @override
  String get chatProcessingError =>
      'Desculpe, tive um problema ao processar sua mensagem. Tente novamente.';

  @override
  String get chatImageAnalyzing => 'Analisando sua imagem... 📸';

  @override
  String get chatDailySummaryDefault => 'Aqui está seu resumo diário:';

  @override
  String get chatInputPlaceholder => 'Digite sua mensagem...';

  @override
  String get loginTagline => 'Seu assistente nutricional com IA';

  @override
  String get loginEmailPlaceholder => 'Email';

  @override
  String get loginPasswordPlaceholder => 'Senha';

  @override
  String get loginEmailRequired => 'Digite seu email';

  @override
  String get loginEmailInvalid => 'Email inválido';

  @override
  String get loginPasswordRequired => 'Digite sua senha';

  @override
  String get loginPasswordLengthError =>
      'Senha deve ter no mínimo 6 caracteres';

  @override
  String get loginButton => 'Entrar';

  @override
  String get loginSignupLink => 'Não tem conta? Cadastre-se';

  @override
  String get signupTitle => 'Criar Conta';

  @override
  String get signupSubtitle => 'Junte-se ao FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => 'Confirmar Senha';

  @override
  String get signupConfirmPasswordRequired => 'Confirme sua senha';

  @override
  String get signupPasswordsMismatch => 'As senhas não coincidem';

  @override
  String get signupTermsAcceptance =>
      'Aceito os termos de uso e política de privacidade';

  @override
  String get signupTermsRequired =>
      'Você deve aceitar os termos para continuar';

  @override
  String get signupButton => 'Criar Conta';

  @override
  String get signupLoginLink => 'Já tem conta? Faça login';

  @override
  String get loadingVerification => 'Verificando login...';

  @override
  String get genderSelectorTitle => 'Selecione seu Sexo Biológico';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Feminino';

  @override
  String get activitySelectorTitle => 'Nível de Atividade Física';

  @override
  String get activitySedentary => 'Sedentário';

  @override
  String get activitySedentaryDesc => 'Pouco ou nenhum exercício';

  @override
  String get activityLight => 'Leve';

  @override
  String get activityLightDesc => 'Exercício leve 1-3 dias/semana';

  @override
  String get activityModerate => 'Moderado';

  @override
  String get activityModerateDesc => 'Exercício moderado 3-5 dias/semana';

  @override
  String get activityHeavy => 'Pesado';

  @override
  String get activityHeavyDesc => 'Exercício intenso 6-7 dias/semana';

  @override
  String get activityAthlete => 'Atleta';

  @override
  String get activityAthleteDesc => 'Exercício muito intenso, trabalho físico';

  @override
  String get goalSelectorTitle => 'Seu Objetivo Principal';

  @override
  String get goalLose => 'Perder Peso';

  @override
  String get goalLoseDesc => 'Déficit calórico de 500 kcal/dia';

  @override
  String get goalMaintain => 'Manter Peso';

  @override
  String get goalMaintainDesc => 'Dieta de manutenção';

  @override
  String get goalGain => 'Ganhar Massa';

  @override
  String get goalGainDesc => 'Superávit calórico de 300 kcal/dia';

  @override
  String get dailySummaryTitle => 'Resumo Diário';

  @override
  String get dailySummaryCalories => 'Calorias';

  @override
  String get dailySummaryProtein => 'Proteína';

  @override
  String get dailySummaryCarbs => 'Carboidratos';

  @override
  String get dailySummaryFat => 'Gordura';

  @override
  String get dailySummaryLeft => 'Restante';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable =>
      'Este idioma ainda não está disponível no FEEDLOG.';

  @override
  String get languageAvailableOptions => 'Idiomas disponíveis';

  @override
  String get languageChangePrompt =>
      'Você gostaria de escolher um idioma diferente?';

  @override
  String get languageChangeConfirm => 'Idioma alterado com sucesso! 🌍';

  @override
  String languageNotSupported(String languages) {
    return 'Este idioma não está disponível. Idiomas disponíveis: $languages';
  }

  @override
  String languageChanged(String language) {
    return 'Idioma alterado para $language! 🌍 A partir de agora responderei neste idioma.';
  }

  @override
  String get languageSelectorTitle => 'Selecione o Idioma';

  @override
  String get languageSelectorPrompt =>
      'Aqui estão os idiomas disponíveis. Selecione o que você prefere:';

  @override
  String get onboardingLanguagePrompt =>
      'Bem-vindo! 🌍 Antes de começar, selecione seu idioma preferido:';

  @override
  String get onboardingLanguageTip =>
      '💡 **Dica:** Você pode mudar o idioma a qualquer momento perguntando \'quais idiomas disponíveis?\' ou dizendo \'mude para [idioma]\'.';

  @override
  String get profilePhotoTitle => 'Foto de Perfil';

  @override
  String get profilePhotoRealTab => 'Foto Real';

  @override
  String get profilePhotoAvatarTab => 'Avatar';

  @override
  String get profilePhotoCamera => 'Câmera';

  @override
  String get profilePhotoGallery => 'Galeria';

  @override
  String get profilePhotoHint =>
      'Escolha uma foto ou selecione um avatar abaixo';

  @override
  String get profilePhotoPrompt =>
      'Agora vamos personalizar seu perfil! 📸 Você pode enviar uma foto real ou escolher um dos nossos avatares divertidos:';

  @override
  String get profilePhotoConfirmation =>
      'Ótima escolha! Seu perfil está ficando muito bom! 😊';

  @override
  String get profilePhotoTip =>
      '💡 **Dica:** Você pode mudar sua foto a qualquer momento dizendo \'trocar minha foto\' ou \'mudar meu avatar\'.';

  @override
  String get profilePhotoChangeRequest =>
      'Claro! Deixa eu te mostrar as opções para atualizar sua foto de perfil:';

  @override
  String get reloadAvatars => 'Novos avatares';

  @override
  String get recentAvatars => 'Avatares recentes';

  @override
  String get closeButton => 'Fechar';
}
