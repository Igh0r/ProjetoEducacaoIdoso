part of 'package:educacao_idoso/main.dart';

class QuizAttempt {
  const QuizAttempt({
    required this.lessonId,
    required this.selectedAnswers,
    required this.score,
    required this.finishedAt,
  });

  final String lessonId;
  final Map<int, int> selectedAnswers;
  final int score;
  final DateTime finishedAt;
}
