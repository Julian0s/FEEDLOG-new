enum MessageSender { user, ai }

enum MessageType {
  text,
  image,
  widget,
  typing, // Added for typing indicator
}

class ChatMessage {
  final String id;
  final String content;
  final MessageSender sender;
  final MessageType type;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata; // For widget data

  ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    this.type = MessageType.text,
    required this.timestamp,
    this.metadata,
  });
}
