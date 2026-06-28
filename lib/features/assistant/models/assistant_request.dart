import 'package:educacao_idoso/features/assistant/models/chat_message.dart';
import 'package:educacao_idoso/features/profile/models/user_profile.dart';

class AssistantRequest {
  const AssistantRequest({required this.question, required this.conversation, required this.acceptedRemoteTerms, required this.appVersion, this.profile, this.locale = 'pt-BR'});
  final String question;
  final List<ChatMessage> conversation;
  final UserProfile? profile;
  final bool acceptedRemoteTerms;
  final String appVersion;
  final String locale;

  Map<String, Object?> toSafeJson({int maxConversationMessages = 8}) {
    final safeConversation = conversation.where((message) => message.text.trim().isNotEmpty).toList().reversed.take(maxConversationMessages).toList().reversed.map((message) => {'role': message.role.name, 'content': _truncate(message.text.trim(), 1200)}).toList();
    final preferences = profile?.preferences.trim();
    return {
      'question': _truncate(question.trim(), 2000),
      'conversation': safeConversation,
      'profileContext': {if (preferences != null && preferences.isNotEmpty) 'preferences': _truncate(preferences, 500)},
      'appVersion': appVersion,
      'locale': locale,
    };
  }

  static String _truncate(String value, int maxLength) => value.length <= maxLength ? value : value.substring(0, maxLength);
}
