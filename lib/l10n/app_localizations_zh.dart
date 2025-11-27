// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'FEEDLOG';

  @override
  String get confirmButton => '确认';

  @override
  String get loadingText => '加载中...';

  @override
  String get onboardingWelcomeMessage =>
      '你好！👋 欢迎来到FEEDLOG！我是你的AI营养助手，很高兴能帮助你实现健康目标！\n\n现在让我们完成你的个人资料，这样我就能为你提供最好的支持。|||你希望我怎么称呼你？';

  @override
  String onboardingNameConfirmation(String name) {
    return '很高兴认识你，$name！😊 现在我需要知道你的生理性别，以便准确计算你的营养档案。';
  }

  @override
  String onboardingGenderPrompt(String name) {
    return '太好了，$name！😊 为了准确计算你的营养档案，我需要知道你的生理性别。WIDGET:gender_selector';
  }

  @override
  String get onboardingAgePrompt => '太棒了！现在告诉我：你多大了？';

  @override
  String get onboardingHeightPrompt => '很好！你的身高是多少？（可以用米或厘米）';

  @override
  String get onboardingWeightPrompt => '明白了！现在告诉我：你目前的体重是多少？';

  @override
  String get onboardingTargetWeightPrompt => '记下了！你的目标体重是多少？（你想达到的体重）';

  @override
  String get onboardingActivityPrompt =>
      '为了计算你的卡路里消耗，我需要知道：你每天的身体活动水平如何？\n\nWIDGET:activity_selector';

  @override
  String get onboardingGoalPrompt =>
      '太棒了！最后一个问题：你的主要目标是什么？\n\nWIDGET:goal_selector';

  @override
  String onboardingResultsMessage(
    String name,
    int tdee,
    int dailyCalories,
    int protein,
    int carbs,
    int fat,
  ) {
    return '🎉 资料完成，$name！\n\n我已经计算了你的营养档案：\n• TDEE：$tdee 千卡/天\n• 每日目标：$dailyCalories 千卡\n• 蛋白质：${protein}g\n• 碳水化合物：${carbs}g\n• 脂肪：${fat}g\n\n现在让我教你如何使用FEEDLOG！';
  }

  @override
  String get onboardingTutorialMessage =>
      '📱 FEEDLOG使用方法：\n\n1️⃣ **记录餐食**：只需告诉我你吃了什么！例如：\'我吃了2个鸡蛋和一根香蕉\'\n\n2️⃣ **查看进度**：问\'我今天吃了多少卡路里？\'或\'我今天怎么样？\'\n\n3️⃣ **更新体重**：说\'我减了1公斤\'或\'我现在80公斤\'\n\n4️⃣ **查询食物**：问\'一个苹果有多少卡路里？\'\n\n一切都通过自然聊天来完成！准备好开始了吗？🚀';

  @override
  String get chatWelcomeBack => '欢迎回来！你今天吃了什么？';

  @override
  String get chatNameError => '抱歉，我无法识别你的名字。你能直接告诉我你想被怎么称呼吗？';

  @override
  String chatAgeConfirmation(int age) {
    return '$age岁，记下了！✅';
  }

  @override
  String get chatAgeError => '请输入有效的年龄（例如：30）。';

  @override
  String chatHeightConfirmation(String height) {
    return '$height米，太棒了！✅';
  }

  @override
  String get chatHeightError => '我不太理解身高。试试像\'1.75\'或\'175cm\'这样的格式。';

  @override
  String chatWeightConfirmation(double weight) {
    return '$weight公斤已记录！✅';
  }

  @override
  String get chatWeightError => '我不太理解体重。试试像\'80kg\'这样的格式。';

  @override
  String chatTargetWeightConfirmation(double weight) {
    return '目标$weight公斤已设定！💪';
  }

  @override
  String get chatTargetWeightError => '你的目标体重是多少？例如：\'70kg\'。';

  @override
  String get chatSelectOptionAbove => '请在上方选择一个选项。';

  @override
  String get chatGenderConfirmation => '记下了！✅';

  @override
  String get chatActivityConfirmation => '完美！💪';

  @override
  String get chatLogoutConfirmation => '明白了！正在退出... 再见！👋';

  @override
  String get chatProcessingError => '抱歉，处理你的消息时出现了问题。请重试。';

  @override
  String get chatImageAnalyzing => '正在分析你的图片... 📸';

  @override
  String get chatDailySummaryDefault => '这是你的每日摘要：';

  @override
  String get chatInputPlaceholder => '输入你的消息...';

  @override
  String get loginTagline => '你的AI营养助手';

  @override
  String get loginEmailPlaceholder => '邮箱';

  @override
  String get loginPasswordPlaceholder => '密码';

  @override
  String get loginEmailRequired => '请输入你的邮箱';

  @override
  String get loginEmailInvalid => '邮箱无效';

  @override
  String get loginPasswordRequired => '请输入你的密码';

  @override
  String get loginPasswordLengthError => '密码至少需要6个字符';

  @override
  String get loginButton => '登录';

  @override
  String get loginSignupLink => '没有账户？注册';

  @override
  String get signupTitle => '创建账户';

  @override
  String get signupSubtitle => '加入FEEDLOG';

  @override
  String get signupConfirmPasswordPlaceholder => '确认密码';

  @override
  String get signupConfirmPasswordRequired => '请确认你的密码';

  @override
  String get signupPasswordsMismatch => '密码不匹配';

  @override
  String get signupTermsAcceptance => '我接受使用条款和隐私政策';

  @override
  String get signupTermsRequired => '你必须接受条款才能继续';

  @override
  String get signupButton => '创建账户';

  @override
  String get signupLoginLink => '已有账户？登录';

  @override
  String get loadingVerification => '正在验证登录...';

  @override
  String get genderSelectorTitle => '选择你的生理性别';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get activitySelectorTitle => '身体活动水平';

  @override
  String get activitySedentary => '久坐';

  @override
  String get activitySedentaryDesc => '很少或没有运动';

  @override
  String get activityLight => '轻度';

  @override
  String get activityLightDesc => '每周轻度运动1-3天';

  @override
  String get activityModerate => '中度';

  @override
  String get activityModerateDesc => '每周中度运动3-5天';

  @override
  String get activityHeavy => '重度';

  @override
  String get activityHeavyDesc => '每周高强度运动6-7天';

  @override
  String get activityAthlete => '运动员';

  @override
  String get activityAthleteDesc => '非常高强度运动，体力劳动';

  @override
  String get goalSelectorTitle => '你的主要目标';

  @override
  String get goalLose => '减重';

  @override
  String get goalLoseDesc => '每天热量赤字500千卡';

  @override
  String get goalMaintain => '保持体重';

  @override
  String get goalMaintainDesc => '维持饮食';

  @override
  String get goalGain => '增肌';

  @override
  String get goalGainDesc => '每天热量盈余300千卡';

  @override
  String get dailySummaryTitle => '每日摘要';

  @override
  String get dailySummaryCalories => '卡路里';

  @override
  String get dailySummaryProtein => '蛋白质';

  @override
  String get dailySummaryCarbs => '碳水化合物';

  @override
  String get dailySummaryFat => '脂肪';

  @override
  String get dailySummaryLeft => '剩余';

  @override
  String get dailySummaryKcal => '千卡';

  @override
  String get languageNotAvailable => '该语言在FEEDLOG中尚不可用。';

  @override
  String get languageAvailableOptions => '可用语言';

  @override
  String get languageChangePrompt => '你想选择其他语言吗？';

  @override
  String get languageChangeConfirm => '语言更改成功！🌍';

  @override
  String languageNotSupported(String languages) {
    return '该语言不可用。可用语言：$languages';
  }

  @override
  String languageChanged(String language) {
    return '语言已更改为$language！🌍 从现在开始我将用这种语言回复。';
  }

  @override
  String get languageSelectorTitle => '选择语言';

  @override
  String get languageSelectorPrompt => '以下是可用的语言。请选择您偏好的语言：';

  @override
  String get onboardingLanguagePrompt => '欢迎！🌍 在开始之前，请选择您偏好的语言：';

  @override
  String get onboardingLanguageTip =>
      '💡 **提示：** 您可以随时通过询问\'有哪些语言可用？\'或说\'切换到[语言]\'来更改语言。';

  @override
  String get profilePhotoTitle => '头像';

  @override
  String get profilePhotoRealTab => '真实照片';

  @override
  String get profilePhotoAvatarTab => '虚拟形象';

  @override
  String get profilePhotoCamera => '相机';

  @override
  String get profilePhotoGallery => '相册';

  @override
  String get profilePhotoHint => '选择照片或在下方选择头像';

  @override
  String get profilePhotoPrompt => '现在让我们个性化您的资料！📸 您可以上传真实照片或选择我们有趣的虚拟形象：';

  @override
  String get profilePhotoConfirmation => '很棒的选择！您的资料看起来很不错！😊';

  @override
  String get profilePhotoTip =>
      '💡 **提示：** 您可以随时通过说\'更换我的照片\'或\'更换我的头像\'来更改照片。';

  @override
  String get profilePhotoChangeRequest => '好的！让我向您展示更新头像的选项：';

  @override
  String get reloadAvatars => 'New avatars';

  @override
  String get recentAvatars => 'Recent avatars';

  @override
  String get closeButton => 'Close';
}
