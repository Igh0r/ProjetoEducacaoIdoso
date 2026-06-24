import 'package:educacao_idoso/features/accessibility/models/accessibility_settings.dart';
import 'package:educacao_idoso/features/learning/models/learning_models.dart';

abstract class TextToSpeechEngine {
  Future<void> setLanguage(String language);
  Future<void> setSpeechRate(double rate);
  Future<void> setVolume(double volume);
  Future<void> stop();
  Future<void> speak(String text);
}

class SilentTextToSpeechEngine implements TextToSpeechEngine {
  @override
  Future<void> setLanguage(String language) async {}
  @override
  Future<void> setSpeechRate(double rate) async {}
  @override
  Future<void> setVolume(double volume) async {}
  @override
  Future<void> speak(String text) async {}
  @override
  Future<void> stop() async {}
}

class TextToSpeechService {
  TextToSpeechService({TextToSpeechEngine? engine}) : _engine = engine ?? SilentTextToSpeechEngine();

  final TextToSpeechEngine _engine;
  bool _configured = false;

  Future<void> speak(String text, {required AccessibilitySettings settings}) async {
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

  Future<void> speakLessonStep(LessonStep step, {required AccessibilitySettings settings}) =>
      speak(_lessonStepText(step), settings: settings);

  Future<void> stop() => _engine.stop();

  String _lessonStepText(LessonStep step) {
    final parts = <String>[step.title, step.content, if (step.tip != null) 'Dica: ${step.tip}', if (step.warning != null) 'Atenção: ${step.warning}'];
    return parts.map(_ensureSentenceEnding).join(' ');
  }

  String _ensureSentenceEnding(String text) {
    final trimmed = text.trim();
    if (trimmed.endsWith('.') || trimmed.endsWith('!') || trimmed.endsWith('?')) return trimmed;
    return '$trimmed.';
  }
}

final textToSpeechService = TextToSpeechService();
