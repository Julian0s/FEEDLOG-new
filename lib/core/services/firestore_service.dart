import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/chat/domain/chat_message.dart';

part 'firestore_service.g.dart';

abstract class FirestoreService {
  Future<void> saveMessage(String userId, ChatMessage message);
  Stream<List<ChatMessage>> getChatHistory(String userId);
  Future<void> saveDailyLog(String userId, Map<String, dynamic> logData);
}

class MockFirestoreService implements FirestoreService {
  final List<ChatMessage> _mockMessages = [];

  @override
  Future<void> saveMessage(String userId, ChatMessage message) async {
    _mockMessages.add(message);
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Stream<List<ChatMessage>> getChatHistory(String userId) {
    return Stream.value(_mockMessages);
  }

  @override
  Future<void> saveDailyLog(String userId, Map<String, dynamic> logData) async {
    // Mock save
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

@riverpod
FirestoreService firestoreService(Ref ref) {
  return MockFirestoreService();
}
