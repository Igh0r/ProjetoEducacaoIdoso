import 'dart:convert';

import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const config = AppConfig(
    assistantApiBaseUrl: 'https://example.test',
    assistantChatPath: '/assistant/chat',
    assistantTimeout: Duration(seconds: 1),
    appVersion: 'test',
    environmentName: 'test',
  );

  AssistantRequest request({bool accepted = true}) => AssistantRequest(
        question: 'Como consultar meu INSS?',
        conversation: [ChatMessage(role: ChatRole.user, text: 'Como consultar meu INSS?')],
        acceptedRemoteTerms: accepted,
        appVersion: 'test',
        profile: const UserProfile(
          name: 'Maria',
          emergencyPhone: '11999999999',
          trustedContactName: 'Ana',
          preferences: 'Letras grandes',
        ),
      );

  test('envia pergunta para backend remoto e interpreta resposta', () async {
    final service = RemoteAssistantService(
      config: config,
      post: (uri, {headers, body, timeout}) async {
        expect(uri.toString(), 'https://example.test/assistant/chat');
        expect(headers?['Content-Type'], 'application/json');
        final payload = jsonDecode(body! as String) as Map<String, Object?>;
        expect(payload['question'], 'Como consultar meu INSS?');
        return AssistantRemoteResponse(statusCode: 200, body: jsonEncode({'answer': 'Use o Meu INSS oficial.', 'policyVersion': 'assistant-safety-v1'}));
      },
    );

    final response = await service.answerFor(request());

    expect(response.answer, 'Use o Meu INSS oficial.');
    expect(response.policyVersion, 'assistant-safety-v1');
  });

  test('bloqueia chamada remota sem consentimento', () async {
    final service = RemoteAssistantService(config: config);

    expect(
      () => service.answerFor(request(accepted: false)),
      throwsA(isA<AssistantException>().having((error) => error.code, 'code', AssistantErrorCode.consentRequired)),
    );
  });

  test('falha quando endpoint remoto não está configurado', () async {
    const missingConfig = AppConfig(
      assistantApiBaseUrl: '',
      assistantChatPath: '/assistant/chat',
      assistantTimeout: Duration(seconds: 1),
      appVersion: 'test',
      environmentName: 'test',
    );
    final service = RemoteAssistantService(config: missingConfig);

    expect(
      () => service.answerFor(request()),
      throwsA(isA<AssistantException>().having((error) => error.code, 'code', AssistantErrorCode.missingConfiguration)),
    );
  });

  test('mapeia rate limit para erro amigável', () async {
    final service = RemoteAssistantService(
      config: config,
      post: (uri, {headers, body, timeout}) async => const AssistantRemoteResponse(statusCode: 429, body: '{}'),
    );

    expect(
      () => service.answerFor(request()),
      throwsA(isA<AssistantException>().having((error) => error.code, 'code', AssistantErrorCode.rateLimited)),
    );
  });

  test('payload remoto não envia telefone nem contato de confiança', () {
    final payload = request().toSafeJson();
    final encoded = jsonEncode(payload);

    expect(encoded, isNot(contains('11999999999')));
    expect(encoded, isNot(contains('Ana')));
    expect(encoded, contains('Letras grandes'));
  });
}
