part of 'package:educacao_idoso/main.dart';

abstract class ProgressRepository {
  Set<String> getCompletedLessons();
  Map<String, int> getQuizScores();
  Map<String, DateTime> getCompletionDates();
  void completeLesson(String lessonId, int score);
}

class InMemoryProgressRepository implements ProgressRepository {
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};
  final Map<String, DateTime> _completionDates = <String, DateTime>{};

  @override
  Set<String> getCompletedLessons() => _completedLessons;

  @override
  Map<String, int> getQuizScores() => _quizScores;

  @override
  Map<String, DateTime> getCompletionDates() => _completionDates;

  @override
  void completeLesson(String lessonId, int score) {
    _completedLessons.add(lessonId);
    _quizScores[lessonId] = score;
    _completionDates[lessonId] = DateTime.now();
  }
}
