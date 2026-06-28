import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:educacao_idoso/core/config/app_config.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_error.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_request.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_response.dart';
import 'package:educacao_idoso/features/assistant/services/assistant_service.dart';

class AssistantRemoteResponse {
  const AssistantRemoteResponse({required this.statusCode, required this.body});

  final int statusCode;
  final String body;
}

typedef AssistantHttpPost = Future<AssistantRemoteResponse> Function(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
  Duration? timeout,
});

class RemoteAssistantService implements AssistantService {
  const RemoteAssistantService({required this.config, AssistantHttpPost? post}) : _post = post;

  final AppConfig config;
  final AssistantHttpPost? _post;

  @override
  Future<AssistantResponse> answerFor(AssistantRequest request) async {
    if (!request.acceptedRemoteTerms) {
      throw const AssistantException(AssistantErrorCode.consentRequired, 'Consentimento remoto pendente.');
    }
    if (!config.hasRemoteAssistant) {
      throw const AssistantException(AssistantErrorCode.missingConfiguration, 'ASSISTANT_API_BASE_URL não configurada.');
    }

    try {
      final post = _post ?? _defaultPost;
      final response = await post(
        config.assistantChatUri(),
        headers: const {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(request.toSafeJson()),
        timeout: config.assistantTimeout,
      ).timeout(config.assistantTimeout);
      return _parseResponse(response);
    } on TimeoutException {
      throw const AssistantException(AssistantErrorCode.timeout, 'Tempo limite excedido.');
    } on SocketException {
      throw const AssistantException(AssistantErrorCode.networkUnavailable, 'Rede indisponível.');
    } on FormatException {
      throw const AssistantException(AssistantErrorCode.invalidResponse, 'JSON inválido.');
    } on AssistantException {
      rethrow;
    } catch (error) {
      throw AssistantException(AssistantErrorCode.unknown, error.toString());
    }
  }

  static Future<AssistantRemoteResponse> _defaultPost(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
    Duration? timeout,
  }) async {
    final client = HttpClient()..connectionTimeout = timeout;
    try {
      final request = await client.postUrl(uri);
      headers?.forEach(request.headers.set);
      request.write(body ?? '');
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      return AssistantRemoteResponse(statusCode: response.statusCode, body: responseBody);
    } finally {
      client.close(force: true);
    }
  }

  AssistantResponse _parseResponse(AssistantRemoteResponse response) {
    if (response.statusCode == 429) {
      throw const AssistantException(AssistantErrorCode.rateLimited, 'Limite de uso atingido.');
    }
    if (response.statusCode == 403 || response.statusCode == 422) {
      throw const AssistantException(AssistantErrorCode.safetyBlocked, 'Resposta bloqueada por segurança.');
    }
    if (response.statusCode >= 500) {
      throw const AssistantException(AssistantErrorCode.serverUnavailable, 'Servidor indisponível.');
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AssistantException(AssistantErrorCode.unknown, 'Status HTTP ${response.statusCode}.');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map) {
      throw const AssistantException(AssistantErrorCode.invalidResponse, 'Resposta não é objeto JSON.');
    }
    final assistantResponse = AssistantResponse.fromJson(Map<String, Object?>.from(decoded));
    if (assistantResponse.answer.trim().isEmpty) {
      throw const AssistantException(AssistantErrorCode.invalidResponse, 'Resposta sem answer.');
    }
    return assistantResponse;
  }
}
