import 'package:educacao_idoso/core/config/app_config.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_error.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_request.dart';
import 'package:educacao_idoso/features/assistant/models/chat_message.dart';
import 'package:educacao_idoso/features/assistant/services/assistant_service.dart';
import 'package:educacao_idoso/features/assistant/services/remote_assistant_service.dart';

class AssistantConversationController {
  AssistantConversationController({AssistantService? service, AppConfig config = appConfig})
      : _service = service ?? RemoteAssistantService(config: config),
        _config = config;

  final AssistantService _service;
  final AppConfig _config;

  Future<ChatMessage> answer(String question, List<ChatMessage> conversation) async {
    final request = AssistantRequest(
      question: question,
      conversation: conversation,
      acceptedRemoteTerms: appState.userProfile.acceptedRemoteAssistantTerms,
      profile: appState.userProfile,
      appVersion: _config.appVersion,
    );

    try {
      final response = await _service.answerFor(request);
      return ChatMessage(role: ChatRole.assistant, text: response.answer.trim());
    } on AssistantException catch (error) {
      return ChatMessage(role: ChatRole.assistant, text: error.friendlyMessage, status: ChatMessageStatus.failed, canRetry: true, errorMessage: error.message);
    }
  }
}
