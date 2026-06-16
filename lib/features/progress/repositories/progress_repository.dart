part of 'package:educacao_idoso/main.dart';

abstract class ProgressRepository {
  Set<String> getCompletedLessons();
  Map<String, int> getQuizScores();
  void completeLesson(String lessonId, int score);
}

class InMemoryProgressRepository implements ProgressRepository {
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};

  @override
  Set<String> getCompletedLessons() => Set.unmodifiable(_completedLessons);

  @override
  Map<String, int> getQuizScores() => Map.unmodifiable(_quizScores);

  @override
  void completeLesson(String lessonId, int score) {
    _completedLessons.add(lessonId);
    _quizScores[lessonId] = score;
  }
}
