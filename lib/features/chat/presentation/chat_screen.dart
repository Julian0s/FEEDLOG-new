import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/l10n/app_localizations.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_container.dart';
import '../domain/chat_message.dart';
import 'providers/chat_provider.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/dynamic_content/daily_summary_widget.dart';
import 'widgets/dynamic_content/activity_selector_widget.dart';
import 'widgets/dynamic_content/goal_selector_widget.dart';
import 'widgets/dynamic_content/gender_selector_widget.dart';
import 'widgets/dynamic_content/language_selector_widget.dart';
import 'widgets/dynamic_content/profile_photo_selector_widget.dart';
import '../../../core/services/firestore_user_service.dart';
import '../../auth/domain/auth_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    ref.read(chatProvider.notifier).sendMessage(_controller.text);
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);
    final userPhoto = ref.watch(userProfilePhotoProvider);

    // Auto-scroll on new messages
    ref.listen(chatProvider, (previous, next) {
      _scrollToBottom();
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('FEEDLOG', style: AppTextStyles.h2),
        centerTitle: true,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: AppColors.deepOcean.withOpacity(0.5),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Color(0xFF1A2C42),
              AppColors.deepOcean,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message.type == MessageType.widget) {
                      return _buildWidgetMessage(message);
                    }
                    return ChatBubble(
                      message: message,
                      userAvatarUrl: userPhoto.avatarUrl,
                      userPhotoUrl: userPhoto.photoUrl,
                    );
                  },
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetMessage(ChatMessage message) {
    final widgetType = message.metadata?['widgetType'];

    Widget? widgetContent;
    switch (widgetType) {
      case 'daily_summary':
        widgetContent = DailySummaryWidget(data: message.metadata!);
        break;
      case 'gender_selector':
        widgetContent = GenderSelectorWidget(
          onConfirmed: (gender) {
            ref.read(chatProvider.notifier).handleWidgetAction('gender_selector', gender);
          },
        );
        break;
      case 'activity_selector':
        widgetContent = ActivitySelectorWidget(
          onConfirmed: (level) {
            ref.read(chatProvider.notifier).handleWidgetAction('activity_selector', level);
          },
        );
        break;
      case 'goal_selector':
        widgetContent = GoalSelectorWidget(
          onConfirmed: (goal) {
            ref.read(chatProvider.notifier).handleWidgetAction('goal_selector', goal);
          },
        );
        break;
      case 'language_selector':
        widgetContent = LanguageSelectorWidget(
          onConfirmed: (languageCode) {
            ref.read(chatProvider.notifier).handleWidgetAction('language_selector', languageCode);
          },
        );
        break;
      case 'profile_photo_selector':
        final isMale = message.metadata?['isMale'] ?? true;
        final user = ref.read(currentUserProvider);
        final firestoreService = ref.read(firestoreUserServiceProvider);
        widgetContent = ProfilePhotoSelectorWidget(
          isMale: isMale,
          onConfirmed: (photoData) {
            ref.read(chatProvider.notifier).handleWidgetAction('profile_photo_selector', photoData);
          },
          onLoadHistory: user != null
              ? () => firestoreService.getAvatarHistory(user.uid)
              : null,
          onSaveToHistory: user != null
              ? (avatarUrl) => firestoreService.addToAvatarHistory(user.uid, avatarUrl)
              : null,
        );
        break;
    }

    if (widgetContent == null) return const SizedBox.shrink();

    // Render widget with AI avatar (like a chat bubble)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.neonMint, AppColors.electricBlue],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonMint.withOpacity(0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.auto_awesome, size: 16, color: Colors.white),
            ),
          ),
          const Gap(8),
          // Widget content
          Expanded(child: widgetContent),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  ref.read(chatProvider.notifier).sendImage(image.path);
                }
              },
              icon: const Icon(Icons.add_circle_outline,
                  color: AppColors.neonMint),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                style: AppTextStyles.body1,
                decoration: InputDecoration(
                  hintText: l10n.chatInputPlaceholder,
                  hintStyle: AppTextStyles.caption,
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: AppColors.electricBlue),
            ),
          ],
        ),
      ),
    );
  }
}
