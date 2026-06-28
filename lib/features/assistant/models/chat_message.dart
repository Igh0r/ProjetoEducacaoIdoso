enum ChatRole { user, assistant }

enum ChatMessageStatus { sending, sent, failed }

class ChatMessage {
  ChatMessage({required this.role, required this.text, DateTime? createdAt, this.status = ChatMessageStatus.sent, this.canRetry = false, this.errorMessage}) : createdAt = createdAt ?? DateTime.now();

  ChatMessage.legacy(bool user, this.text)
      : role = user ? ChatRole.user : ChatRole.assistant,
        createdAt = DateTime.now(),
        status = ChatMessageStatus.sent,
        canRetry = false,
        errorMessage = null;

  final ChatRole role;
  final String text;
  final DateTime createdAt;
  final ChatMessageStatus status;
  final bool canRetry;
  final String? errorMessage;
  bool get user => role == ChatRole.user;

  ChatMessage copyWith({ChatRole? role, String? text, DateTime? createdAt, ChatMessageStatus? status, bool? canRetry, String? errorMessage}) => ChatMessage(
        role: role ?? this.role,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        canRetry: canRetry ?? this.canRetry,
        errorMessage: errorMessage,
      );
}
