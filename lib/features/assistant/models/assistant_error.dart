enum AssistantErrorCode { missingConfiguration, consentRequired, networkUnavailable, timeout, rateLimited, serverUnavailable, invalidResponse, safetyBlocked, unknown }

class AssistantException implements Exception {
  const AssistantException(this.code, this.message);
  final AssistantErrorCode code;
  final String message;
  String get friendlyMessage {
    switch (code) {
      case AssistantErrorCode.missingConfiguration:
        return 'A IA online ainda não foi configurada neste aparelho. Peça ajuda ao responsável pelo aplicativo.';
      case AssistantErrorCode.consentRequired:
        return 'Para usar o assistente, primeiro confirme que entendeu que a pergunta será enviada para uma IA online.';
      case AssistantErrorCode.networkUnavailable:
        return 'Não consegui acessar a IA agora. Verifique sua internet e tente novamente.';
      case AssistantErrorCode.timeout:
        return 'A IA demorou para responder. Tente novamente em alguns instantes.';
      case AssistantErrorCode.rateLimited:
        return 'Muitas perguntas foram enviadas agora. Aguarde alguns minutos e tente novamente.';
      case AssistantErrorCode.serverUnavailable:
        return 'O serviço de IA está indisponível no momento. Tente novamente mais tarde.';
      case AssistantErrorCode.invalidResponse:
        return 'Recebi uma resposta inesperada da IA. Tente novamente.';
      case AssistantErrorCode.safetyBlocked:
        return 'Não posso ajudar com essa solicitação. Não envie senhas, códigos, documentos ou dados bancários.';
      case AssistantErrorCode.unknown:
        return 'Não consegui responder agora. Tente novamente em alguns instantes.';
    }
  }
  @override
  String toString() => 'AssistantException($code, $message)';
}
