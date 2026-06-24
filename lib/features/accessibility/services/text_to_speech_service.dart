part of 'package:educacao_idoso/main.dart';

abstract class TextToSpeechEngine {
  Future<void> setLanguage(String language);
  Future<void> setSpeechRate(double rate);
  Future<void> setVolume(double volume);
  Future<void> stop();
  Future<void> speak(String text);
}

class FlutterTextToSpeechEngine implements TextToSpeechEngine {
  FlutterTextToSpeechEngine({FlutterTts? flutterTts}) : _flutterTts = flutterTts ?? FlutterTts();

  final FlutterTts _flutterTts;

  @override
  Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  @override
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  @override
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}

class TextToSpeechService {
  TextToSpeechService({TextToSpeechEngine? engine}) : _engine = engine ?? FlutterTextToSpeechEngine();

  final TextToSpeechEngine _engine;
  bool _configured = false;

  Future<void> speak(
    String text, {
    required AccessibilitySettings settings,
  }) async {
    await stop();
    if (!settings.readAloudEnabled || text.trim().isEmpty) return;

    if (!_configured) {
      await _engine.setLanguage('pt-BR');
      await _engine.setSpeechRate(0.42);
      await _engine.setVolume(1);
      _configured = true;
    }

    await _engine.speak(text.trim());
  }

  Future<void> speakLessonStep(
    LessonStep step, {
    required AccessibilitySettings settings,
  }) =>
      speak(_lessonStepText(step), settings: settings);

  Future<void> stop() => _engine.stop();

  String _lessonStepText(LessonStep step) {
    final parts = <String>[
      step.title,
      step.content,
      if (step.tip != null) 'Dica: ${step.tip}',
      if (step.warning != null) 'Atenção: ${step.warning}',
    ];

    return parts.map(_ensureSentenceEnding).join(' ');
  }

  String _ensureSentenceEnding(String text) {
    final trimmed = text.trim();
    if (trimmed.endsWith('.') || trimmed.endsWith('!') || trimmed.endsWith('?')) {
      return trimmed;
    }

    return '$trimmed.';
  }
}

final textToSpeechService = TextToSpeechService();
