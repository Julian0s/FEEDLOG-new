// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => '確認';

  @override
  String get loadingText => '読み込み中...';

  @override
  String get onboardingWelcomeMessage =>
      'こんにちは！👋 FEEDLOGへようこそ！私はあなたのAI栄養アシスタントです。あなたの健康目標達成をお手伝いできることを嬉しく思います！\n\nプロフィールを完成させて、最高のサポートを提供できるようにしましょう。|||何とお呼びすればよいですか？';

  @override
  String onboardingNameConfirmation(String name) {
    return 'はじめまして、$nameさん！😊 栄養プロフィールを正確に計算するために、生物学的性別を教えてください。';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return '完璧です、$nameさん！😊 栄養プロフィールを正確に計算するために、生物学的性別を知る必要があります。WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => '素晴らしい！何歳ですか？';

  @override
  String get onboardingHeightPrompt => '完璧！身長はどのくらいですか？（メートルまたはセンチメートルで）';

  @override
  String get onboardingWeightPrompt => 'わかりました！現在の体重は何キロですか？';

  @override
  String get onboardingTargetWeightPrompt => 'メモしました！目標体重は何キロですか？（達成したい体重）';

  @override
  String get onboardingActivityPrompt =>
      'カロリー消費量を計算するために、日々の身体活動レベルを教えてください。\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      '素晴らしい！最後の質問です：主な目標は何ですか？\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 プロフィール完成、$nameさん！\n\n栄養プロフィールを計算しました：\n• TDEE：$tdee kcal/日\n• 日々の目標：$dailyCalories kcal\n• タンパク質：${protein}g\n• 炭水化物：${carbs}g\n• 脂質：${fat}g\n\nFEEDLOGの使い方をお教えします！';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 FEEDLOGの使い方：\n\n1️⃣ **食事を記録**：食べたものを教えてください！例：「卵2個とバナナを食べました」\n\n2️⃣ **進捗を確認**：「今日何カロリー食べた？」や「今日はどう？」と聞いてください\n\n3️⃣ **体重を更新**：「1kg減った」や「80kgです」と言ってください\n\n4️⃣ **食品を調べる**：「りんごは何カロリー？」と聞いてください\n\n自然な会話ですべてが機能します！始める準備はできましたか？🚀';

  @override
  String get chatWelcomeBack => 'おかえりなさい！今日は何を食べましたか？';

  @override
  String get chatNameError => 'すみません、お名前を認識できませんでした。どう呼ばれたいか教えていただけますか？';

  @override
  String chatAgeConfirmation(int age) {
    return '$age歳、メモしました！✅';
  }

  @override
  String get chatAgeError => '有効な年齢を入力してください（例：30）。';

  @override
  String chatHeightConfirmation(String height) {
    return '${height}m、素晴らしい！✅';
  }

  @override
  String get chatHeightError => '身長がわかりませんでした。「1.75」や「175cm」のように入力してみてください。';

  @override
  String chatWeightConfirmation(double weight) {
    return '${weight}kg記録しました！✅';
  }

  @override
  String get chatWeightError => '体重がわかりませんでした。「80kg」のように入力してみてください。';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return '目標${weight}kg設定しました！💪';
  }

  @override
  String get chatTargetWeightError => '目標体重は何kgですか？例：「70kg」';

  @override
  String get chatSelectOptionAbove => '上のオプションから選択してください。';

  @override
  String get chatGenderConfirmation => 'メモしました！✅';

  @override
  String get chatActivityConfirmation => '完璧！💪';

  @override
  String get chatLogoutConfirmation => 'わかりました！ログアウト中... またね！👋';

  @override
  String get chatProcessingError => 'すみません、メッセージの処理中に問題が発生しました。もう一度お試しください。';

  @override
  String get chatImageAnalyzing => '画像を分析中... 📸';

  @override
  String get chatDailySummaryDefault => '本日のまとめです：';

  @override
  String get chatInputPlaceholder => 'メッセージを入力...';

  @override
  String get loginTagline => 'あなたのAI栄養アシスタント';

  @override
  String get loginEmailPlaceholder => 'メール';

  @override
  String get loginPasswordPlaceholder => 'パスワード';

  @override
  String get loginEmailRequired => 'メールを入力してください';

  @override
  String get loginEmailInvalid => '無効なメール';

  @override
  String get loginPasswordRequired => 'パスワードを入力してください';

  @override
  String get loginPasswordLengthError => 'パスワードは6文字以上必要です';

  @override
  String get loginButton => 'ログイン';

  @override
  String get loginSignupLink => 'アカウントをお持ちでないですか？登録';

  @override
  String get signupTitle => 'アカウント作成';

  @override
  String get signupSubtitle => 'FEEDLOGに参加';

  @override
  String get signupConfirmPasswordPlaceholder => 'パスワード確認';

  @override
  String get signupConfirmPasswordRequired => 'パスワードを確認してください';

  @override
  String get signupPasswordsMismatch => 'パスワードが一致しません';

  @override
  String get signupTermsAcceptance => '利用規約とプライバシーポリシーに同意します';

  @override
  String get signupTermsRequired => '続行するには利用規約に同意する必要があります';

  @override
  String get signupButton => 'アカウント作成';

  @override
  String get signupLoginLink => 'すでにアカウントをお持ちですか？ログイン';

  @override
  String get loadingVerification => 'ログインを確認中...';

  @override
  String get genderSelectorTitle => '生物学的性別を選択';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get activitySelectorTitle => '身体活動レベル';

  @override
  String get activitySedentary => '座りがち';

  @override
  String get activitySedentaryDesc => '運動はほとんどなし';

  @override
  String get activityLight => '軽度';

  @override
  String get activityLightDesc => '週1-3日の軽い運動';

  @override
  String get activityModerate => '中程度';

  @override
  String get activityModerateDesc => '週3-5日の中程度の運動';

  @override
  String get activityHeavy => '激しい';

  @override
  String get activityHeavyDesc => '週6-7日の激しい運動';

  @override
  String get activityAthlete => 'アスリート';

  @override
  String get activityAthleteDesc => '非常に激しい運動、肉体労働';

  @override
  String get goalSelectorTitle => '主な目標';

  @override
  String get goalLose => '減量';

  @override
  String get goalLoseDesc => '1日500kcalのカロリー不足';

  @override
  String get goalMaintain => '体重維持';

  @override
  String get goalMaintainDesc => '維持食';

  @override
  String get goalGain => '筋肉増量';

  @override
  String get goalGainDesc => '1日300kcalのカロリー過剰';

  @override
  String get dailySummaryTitle => '本日のまとめ';

  @override
  String get dailySummaryCalories => 'カロリー';

  @override
  String get dailySummaryProtein => 'タンパク質';

  @override
  String get dailySummaryCarbs => '炭水化物';

  @override
  String get dailySummaryFat => '脂質';

  @override
  String get dailySummaryLeft => '残り';

  @override
  String get dailySummaryKcal => 'kcal';

  @override
  String get languageNotAvailable => 'この言語はFEEDLOGではまだ利用できません。';

  @override
  String get languageAvailableOptions => '利用可能な言語';

  @override
  String get languageChangePrompt => '他の言語を選びますか？';

  @override
  String get languageChangeConfirm => '言語を変更しました！🌍';

  @override
  String languageNotSupported(String languages) {
    return 'この言語は利用できません。利用可能な言語：$languages';
  }

  @override
  String languageChanged(String language) {
    return '言語を$languageに変更しました！🌍 これからはこの言語で返信します。';
  }

  @override
  String get languageSelectorTitle => '言語を選択';

  @override
  String get languageSelectorPrompt => '利用可能な言語はこちらです。お好みの言語を選択してください：';

  @override
  String get onboardingLanguagePrompt => 'ようこそ！🌍 始める前に、お好みの言語を選択してください：';

  @override
  String get onboardingLanguageTip =>
      '💡 **ヒント：** 「どの言語が使えますか？」と聞くか、「[言語]に変更して」と言うことで、いつでも言語を変更できます。';

  @override
  String get profilePhotoTitle => 'プロフィール写真';

  @override
  String get profilePhotoRealTab => '本物の写真';

  @override
  String get profilePhotoAvatarTab => 'アバター';

  @override
  String get profilePhotoCamera => 'カメラ';

  @override
  String get profilePhotoGallery => 'ギャラリー';

  @override
  String get profilePhotoHint => '写真を選ぶか、下からアバターを選んでください';

  @override
  String get profilePhotoPrompt =>
      'さあ、プロフィールをカスタマイズしましょう！📸 本物の写真をアップロードするか、楽しいアバターを選んでください：';

  @override
  String get profilePhotoConfirmation => '素晴らしい選択です！プロフィールがとても良く見えます！😊';

  @override
  String get profilePhotoTip =>
      '💡 **ヒント：** 「写真を変更して」や「アバターを変更して」と言えば、いつでも写真を変更できます。';

  @override
  String get profilePhotoChangeRequest => 'もちろん！プロフィール写真を更新するオプションをお見せします：';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
