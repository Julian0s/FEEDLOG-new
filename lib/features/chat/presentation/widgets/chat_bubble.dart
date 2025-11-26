import 'dart:ui';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/features/chat/domain/chat_message.dart';
import 'package:nutriai/features/chat/presentation/widgets/typing_indicator.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(),
            const Gap(8),
          ],
          Flexible(
            child: GlassContainer(
              padding: const EdgeInsets.all(12),
              backgroundColor: isUser
                  ? AppColors.neonMint.withOpacity(0.1)
                  : AppColors.glassMedium,
              borderColor: isUser
                  ? AppColors.neonMint.withOpacity(0.3)
                  : AppColors.glassLight,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 20),
              ),
              child: _buildContent(),
            ),
          ),
          if (isUser) ...[
            const Gap(8),
            _buildUserAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (message.type) {
      case MessageType.image:
        if (kIsWeb) {
          return Image.network(
            message.content,
            fit: BoxFit.cover,
            height: 200,
            width: 200,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white),
          );
        } else {
          return Image.file(
            File(message.content),
            fit: BoxFit.cover,
            height: 200,
            width: 200,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white),
          );
        }
      case MessageType.typing:
        return const TypingIndicator();
      case MessageType.widget:
        return const SizedBox.shrink(); // Widgets are handled in ChatScreen
      case MessageType.text:
      default:
        return Text(
          message.content,
          style: AppTextStyles.body1.copyWith(
            color: message.sender == MessageSender.user ? AppColors.neonMint : Colors.white,
          ),
        );
    }
  }

  Widget _buildAvatar() {
    return Container(
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
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.glassMedium,
        border: Border.all(color: AppColors.glassLight),
      ),
      child: const Center(
        child: Icon(Icons.person, size: 16, color: Colors.white),
      ),
    );
  }
}
