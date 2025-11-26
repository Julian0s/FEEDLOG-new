// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => '확인';

  @override
  String get loadingText => '로딩 중...';

  @override
  String get onboardingWelcomeMessage =>
      '안녕하세요! 👋 FEEDLOG에 오신 것을 환영합니다! 저는 AI 영양 도우미이며, 건강 목표 달성을 도와드리게 되어 기쁩니다!\n\n최고의 지원을 제공할 수 있도록 프로필을 완성해 봅시다.|||뭐라고 불러드릴까요?';

  @override
  String onboardingNameConfirmation(String name) {
    return '만나서 반갑습니다, $name님! 😊 이제 영양 프로필을 정확하게 계산하기 위해 생물학적 성별을 알아야 합니다.';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return '완벽해요, $name님! 😊 영양 프로필을 정확하게 계산하기 위해 생물학적 성별을 알아야 합니다. WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => '좋아요! 이제 말씀해 주세요: 몇 살이신가요?';

  @override
  String get onboardingHeightPrompt => '완벽해요! 키는 얼마인가요? (미터 또는 센티미터로)';

  @override
  String get onboardingWeightPrompt => '알겠어요! 이제 말씀해 주세요: 현재 체중은 얼마인가요?';

  @override
  String get onboardingTargetWeightPrompt =>
      '기록했어요! 목표 체중은 얼마인가요? (달성하고 싶은 체중)';

  @override
  String get onboardingActivityPrompt =>
      '칼로리 소비량을 계산하기 위해 알아야 합니다: 일상적인 신체 활동 수준은 어떤가요?\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      '좋아요! 마지막 질문: 주요 목표는 무엇인가요?\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 프로필 완성, $name님!\n\n영양 프로필을 계산했습니다:\n• TDEE: $tdee kcal/일\n• 일일 목표: $dailyCalories kcal\n• 단백질: ${protein}g\n• 탄수화물: ${carbs}g\n• 지방: ${fat}g\n\n이제 FEEDLOG 사용법을 알려드릴게요!';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 FEEDLOG 사용법:\n\n1️⃣ **식사 기록**: 뭘 먹었는지 말씀해 주세요! 예: \'달걀 2개와 바나나를 먹었어요\'\n\n2️⃣ **진행 상황 확인**: \'오늘 몇 칼로리 먹었어?\' 또는 \'오늘 어때?\'라고 물어보세요\n\n3️⃣ **체중 업데이트**: \'1kg 빠졌어\' 또는 \'80kg이야\'라고 말씀하세요\n\n4️⃣ **음식 조회**: \'사과는 몇 칼로리야?\'라고 물어보세요\n\n모든 것이 자연스러운 대화로 작동합니다! 시작할 준비됐나요? 🚀';

  @override
  String get chatWelcomeBack => '돌아오셨네요! 오늘 뭘 드셨나요?';

  @override
  String get chatNameError => '죄송해요, 이름을 인식하지 못했어요. 뭐라고 불러드릴지 적어주시겠어요?';

  @override
  String chatAgeConfirmation(int age) {
    return '$age세, 기록했어요! ✅';
  }

  @override
  String get chatAgeError => '유효한 나이를 입력해 주세요 (예: 30).';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m, 좋아요! ✅';
  }

  @override
  String get chatHeightError =>
      '키를 이해하지 못했어요. \'1.75\' 또는 \'175cm\' 같이 입력해 보세요.';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg 기록됨! ✅';
  }

  @override
  String get chatWeightError => '체중을 이해하지 못했어요. \'80kg\' 같이 입력해 보세요.';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return '목표 ${weight}kg 설정됨! 💪';
  }

  @override
  String get chatTargetWeightError => '목표 체중은 얼마인가요? 예: \'70kg\'.';

  @override
  String get chatSelectOptionAbove => '위에서 옵션을 선택해 주세요.';

  @override
  String get chatGenderConfirmation => '기록했어요! ✅';

  @override
  String get chatActivityConfirmation => '완벽해요! 💪';

  @override
  String get chatLogoutConfirmation => '알겠어요! 로그아웃 중... 다음에 봐요! 👋';

  @override
  String get chatProcessingError => '죄송해요, 메시지 처리 중 문제가 발생했어요. 다시 시도해 주세요.';

  @override
  String get chatImageAnalyzing => '이미지 분석 중... 📸';

  @override
  String get chatDailySummaryDefault => '오늘의 요약입니다:';

  @override
  String get chatInputPlaceholder => '메시지 입력...';

  @override
  String get loginTagline => 'AI 영양 도우미';

  @override
  String get loginEmailPlaceholder => '이메일';

  @override
  String get loginPasswordPlaceholder => '비밀번호';

  @override
  String get loginEmailRequired => '이메일을 입력하세요';

  @override
  String get loginEmailInvalid => '유효하지 않은 이메일';

  @override
  String get loginPasswordRequired => '비밀번호를 입력하세요';

  @override
  String get loginPasswordLengthError => '비밀번호는 최소 6자 이상이어야 합니다';

  @override
  String get loginButton => '로그인';

  @override
  String get loginSignupLink => '계정이 없으신가요? 가입';

  @override
  String get signupTitle => '계정 만들기';

  @override
  String get signupSubtitle => 'FEEDLOG 가입';

  @override
  String get signupConfirmPasswordPlaceholder => '비밀번호 확인';

  @override
  String get signupConfirmPasswordRequired => '비밀번호를 확인하세요';

  @override
  String get signupPasswordsMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get signupTermsAcceptance => '이용약관 및 개인정보 처리방침에 동의합니다';

  @override
  String get signupTermsRequired => '계속하려면 약관에 동의해야 합니다';

  @override
  String get signupButton => '계정 만들기';

  @override
  String get signupLoginLink => '이미 계정이 있으신가요? 로그인';

  @override
  String get loadingVerification => '로그인 확인 중...';

  @override
  String get genderSelectorTitle => '생물학적 성별 선택';

  @override
  String get genderMale => '남성';

  @override
  String get genderFemale => '여성';

  @override
  String get activitySelectorTitle => '신체 활동 수준';

  @override
  String get activitySedentary => '앉아있는';

  @override
  String get activitySedentaryDesc => '운동 거의 없음';

  @override
  String get activityLight => '가벼운';

  @override
  String get activityLightDesc => '주 1-3일 가벼운 운동';

  @override
  String get activityModerate => '보통';

  @override
  String get activityModerateDesc => '주 3-5일 보통 운동';

  @override
  String get activityHeavy => '격렬한';

  @override
  String get activityHeavyDesc => '주 6-7일 격렬한 운동';

  @override
  String get activityAthlete => '운동선수';

  @override
  String get activityAthleteDesc => '매우 격렬한 운동, 육체 노동';

  @override
  String get goalSelectorTitle => '주요 목표';

  @override
  String get goalLose => '체중 감량';

  @override
  String get goalLoseDesc => '하루 500kcal 칼로리 결손';

  @override
  String get goalMaintain => '체중 유지';

  @override
  String get goalMaintainDesc => '유지 식단';

  @override
  String get goalGain => '근육 증가';

  @override
  String get goalGainDesc => '하루 300kcal 칼로리 잉여';

  @override
  String get dailySummaryTitle => '일일 요약';

  @override
  String get dailySummaryCalories => '칼로리';

  @override
  String get dailySummaryProtein => '단백질';

  @override
  String get dailySummaryCarbs => '탄수화물';

  @override
  String get dailySummaryFat => '지방';

  @override
  String get dailySummaryLeft => '남음';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable => '이 언어는 아직 FEEDLOG에서 사용할 수 없습니다.';

  @override
  String get languageAvailableOptions => '사용 가능한 언어';

  @override
  String get languageChangePrompt => '다른 언어를 선택하시겠어요?';

  @override
  String get languageChangeConfirm => '언어가 변경되었습니다! 🌍';

  @override
  String languageNotSupported(String languages) {
    return '이 언어는 사용할 수 없습니다. 사용 가능한 언어: $languages';
  }

  @override
  String languageChanged(String language) {
    return '언어가 $language로 변경되었습니다! 🌍 이제 이 언어로 응답하겠습니다.';
  }

  @override
  String get languageSelectorTitle => '언어 선택';

  @override
  String get languageSelectorPrompt => '사용 가능한 언어입니다. 원하는 언어를 선택하세요:';

  @override
  String get onboardingLanguagePrompt => '환영합니다! 🌍 시작하기 전에 원하는 언어를 선택해 주세요:';

  @override
  String get onboardingLanguageTip =>
      '💡 **팁:** \'어떤 언어를 사용할 수 있나요?\'라고 묻거나 \'[언어]로 변경해 줘\'라고 말하면 언제든지 언어를 변경할 수 있습니다.';
}
