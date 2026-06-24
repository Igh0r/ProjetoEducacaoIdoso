import 'package:educacao_idoso/features/accessibility/models/accessibility_settings.dart';
import 'package:educacao_idoso/features/learning/models/quiz_attempt.dart';

abstract class ProgressRepository {
  Set<String> getCompletedLessons();
  Map<String, int> getQuizScores();
  Map<String, List<QuizAttempt>> getQuizAttempts();
  Map<String, DateTime> getCompletionDates();
  AccessibilitySettings getAccessibilitySettings();
  QuizAttempt? getLatestQuizAttempt(String lessonId);
  QuizAttempt? getBestQuizAttempt(String lessonId);
  void completeLesson(String lessonId, int score);
  void saveQuizAttempt(QuizAttempt attempt);
  void saveAccessibilitySettings(AccessibilitySettings settings);
}

class InMemoryProgressRepository implements ProgressRepository {
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};
  final Map<String, DateTime> _completionDates = <String, DateTime>{};
  final Map<String, List<QuizAttempt>> _quizAttempts = <String, List<QuizAttempt>>{};
  AccessibilitySettings _accessibilitySettings = const AccessibilitySettings();

  @override
  Set<String> getCompletedLessons() => Set.unmodifiable(_completedLessons);

  @override
  Map<String, int> getQuizScores() => Map.unmodifiable(_quizScores);

  @override
  Map<String, DateTime> getCompletionDates() => Map.unmodifiable(_completionDates);

  @override
  Map<String, List<QuizAttempt>> getQuizAttempts() => Map.unmodifiable(
        _quizAttempts.map((lessonId, attempts) => MapEntry(lessonId, List.unmodifiable(attempts))),
      );

  @override
  AccessibilitySettings getAccessibilitySettings() => _accessibilitySettings;

  @override
  QuizAttempt? getLatestQuizAttempt(String lessonId) {
    final attempts = _quizAttempts[lessonId];
    if (attempts == null || attempts.isEmpty) return null;
    return attempts.reduce((latest, attempt) => attempt.finishedAt.isAfter(latest.finishedAt) ? attempt : latest);
  }

  @override
  QuizAttempt? getBestQuizAttempt(String lessonId) {
    final attempts = _quizAttempts[lessonId];
    if (attempts == null || attempts.isEmpty) return null;
    return attempts.reduce((best, attempt) => attempt.score > best.score ? attempt : best);
  }

  @override
  void completeLesson(String lessonId, int score) {
    _completedLessons.add(lessonId);
    _quizScores[lessonId] = score;
    _completionDates[lessonId] = DateTime.now();
  }

  @override
  void saveQuizAttempt(QuizAttempt attempt) {
    _quizAttempts.putIfAbsent(attempt.lessonId, () => <QuizAttempt>[]).add(attempt);
    _completedLessons.add(attempt.lessonId);
    _quizScores[attempt.lessonId] = attempt.score;
    _completionDates[attempt.lessonId] = attempt.finishedAt;
  }

  @override
  void saveAccessibilitySettings(AccessibilitySettings settings) {
    _accessibilitySettings = settings;
  }
}
