import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeTextToSpeechEngine implements TextToSpeechEngine {
  final calls = <String>[];

  @override
  Future<void> setLanguage(String language) async {
    calls.add('language:$language');
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    calls.add('rate:$rate');
  }

  @override
  Future<void> setVolume(double volume) async {
    calls.add('volume:$volume');
  }

  @override
  Future<void> speak(String text) async {
    calls.add('speak:$text');
  }

  @override
  Future<void> stop() async {
    calls.add('stop');
  }
}

void main() {
  test('não fala quando a leitura em voz alta está desativada', () async {
    final engine = FakeTextToSpeechEngine();
    final service = TextToSpeechService(engine: engine);

    await service.speak(
      'Texto da explicação',
      settings: const AccessibilitySettings(readAloudEnabled: false),
    );

    expect(engine.calls, ['stop']);
  });

  test('configura o motor e fala texto quando recurso está ativado', () async {
    final engine = FakeTextToSpeechEngine();
    final service = TextToSpeechService(engine: engine);

    await service.speak(
      '  Texto da explicação  ',
      settings: const AccessibilitySettings(readAloudEnabled: true),
    );

    expect(engine.calls, [
      'stop',
      'language:pt-BR',
      'rate:0.42',
      'volume:1.0',
      'speak:Texto da explicação',
    ]);
  });

  test('monta a leitura do passo com título, conteúdo, dica e aviso', () async {
    final engine = FakeTextToSpeechEngine();
    final service = TextToSpeechService(engine: engine);

    await service.speakLessonStep(
      const LessonStep(
        'Abra o app',
        'Toque no ícone para começar.',
        '📱',
        tip: 'Use letras grandes.',
        warning: 'Não compartilhe sua senha.',
      ),
      settings: const AccessibilitySettings(readAloudEnabled: true),
    );

    expect(
      engine.calls.last,
      'speak:Abra o app. Toque no ícone para começar. Dica: Use letras grandes. Atenção: Não compartilhe sua senha.',
    );
  });
}
