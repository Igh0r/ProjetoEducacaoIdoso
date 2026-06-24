abstract class ProgressRepository {
  Set<String> getCompletedLessons();
  Map<String, int> getQuizScores();
  Map<String, List<QuizAttempt>> getQuizAttempts();
  QuizAttempt? getLatestQuizAttempt(String lessonId);
  QuizAttempt? getBestQuizAttempt(String lessonId);
  void completeLesson(String lessonId, int score);
  void saveQuizAttempt(QuizAttempt attempt);
}

class InMemoryProgressRepository implements ProgressRepository {
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};
  final Map<String, List<QuizAttempt>> _quizAttempts = <String, List<QuizAttempt>>{};

  @override
  Set<String> getCompletedLessons() => Set.unmodifiable(_completedLessons);

  @override
  Map<String, int> getQuizScores() => Map.unmodifiable(_quizScores);

  @override
  Map<String, List<QuizAttempt>> getQuizAttempts() => _quizAttempts;

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

    final db = _database;
    if (db == null) return;

    unawaited(db.insert(
      _completedLessonsTable,
      <String, Object?>{
        'lesson_id': lessonId,
        'score': score,
        'completed_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    ));
  }

  @override
  AccessibilitySettings getAccessibilitySettings() => AccessibilitySettings.fromLocalProgressJson(_localProgressAccessibility);

  @override
  void saveAccessibilitySettings(AccessibilitySettings settings) {
    _localProgressAccessibility = settings.toLocalProgressJson();
  }

  @override
  void saveQuizAttempt(QuizAttempt attempt) {
    _quizAttempts.putIfAbsent(attempt.lessonId, () => <QuizAttempt>[]).add(attempt);
    completeLesson(attempt.lessonId, attempt.score);
  }
}
