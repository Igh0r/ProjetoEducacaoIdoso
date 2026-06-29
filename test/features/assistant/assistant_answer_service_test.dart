import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('responde dúvidas de segurança e PIX localmente', () {
    expect(assistantAnswerService.answerFor('golpe'), contains('senha'));
    expect(assistantAnswerService.answerFor('PIX'), contains('confira'));
  });

  test('responde intenção de WhatsApp', () {
    expect(assistantAnswerService.answerFor('Como mando mensagem no zap?'),
        contains('WhatsApp'));
  });

  test('responde intenção de INSS', () {
    expect(assistantAnswerService.answerFor('Quero ver meu benefício do INSS'),
        contains('135'));
  });

  test('responde intenção de SUS', () {
    expect(assistantAnswerService.answerFor('Preciso marcar consulta no SUS'),
        contains('UBS'));
  });

  test('responde intenção de banco', () {
    expect(assistantAnswerService.answerFor('Problema no cartão do banco'),
        contains('aplicativo oficial'));
  });

  test('responde intenção de internet', () {
    expect(assistantAnswerService.answerFor('Como ligar o wifi da internet?'),
        contains('Wi-Fi'));
  });

  test('responde intenção de senha', () {
    expect(assistantAnswerService.answerFor('Esqueci minha senha'),
        contains('Esqueci minha senha'));
  });

  test('responde intenção de compras online', () {
    expect(assistantAnswerService.answerFor('Quero comprar online'),
        contains('lojas conhecidas'));
  });

  test('responde intenção de transporte', () {
    expect(assistantAnswerService.answerFor('Como chamar um taxi?'),
        contains('placa'));
  });

  test('responde intenção de localização', () {
    expect(assistantAnswerService.answerFor('Preciso ver o endereço no mapa'),
        contains('localização'));
  });

  test('responde intenção de emergência', () {
    expect(assistantAnswerService.answerFor('Preciso de socorro emergencia'),
        contains('192'));
  });

  test('entende variações comuns com e sem acento', () {
    expect(assistantAnswerService.answerFor('seguranca'), contains('senha'));
    expect(assistantAnswerService.answerFor('ônibus'), contains('veículo'));
    expect(assistantAnswerService.answerFor('localizacao'),
        contains('localização'));
  });

  test('responde usando GPT integrado quando o cliente retorna conteúdo',
      () async {
    final service = AssistantAnswerService(
      gptClient: _FakeGptAssistantClient(
        answer: 'Resposta GPT integrada sobre segurança digital.',
      ),
    );

    final answer = await service.answerForIntegrated('Como evitar golpes?');

    expect(answer, 'Resposta GPT integrada sobre segurança digital.');
  });

  test('mantém resposta local quando o GPT integrado falha', () async {
    final service = AssistantAnswerService(
      gptClient: _FakeGptAssistantClient(throwsError: true),
    );

    final answer = await service.answerForIntegrated('Como usar PIX?');

    expect(answer, contains('confira'));
  });
}

class _FakeGptAssistantClient implements GptAssistantClient {
  const _FakeGptAssistantClient({
    String? answer,
    this.throwsError = false,
  }) : answerText = answer;

  final String? answerText;
  final bool throwsError;

  @override
  Future<String?> answer(String question, {UserProfile? profile}) async {
    if (throwsError) {
      throw Exception('Falha simulada no GPT');
    }

    return answerText;
  }
}
