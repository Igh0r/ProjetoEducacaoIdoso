import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('marca aula como concluída e registra pontuação do quiz', () {
    final state = AppState();

    state.completeLesson('tech-1', 2);

    expect(state.completedLessons, contains('tech-1'));
    expect(state.quizScores['tech-1'], 2);
  });

  test('não duplica aulas concluídas ao repetir a mesma aula', () {
    final state = AppState();

    state
      ..completeLesson('tech-1', 1)
      ..completeLesson('tech-1', 2);

    expect(state.completedLessons.length, 1);
    expect(state.quizScores['tech-1'], 2);
  });

  test('calcula minutos estudados pelas aulas concluídas', () {
    final state = AppState();

    state
      ..completeLesson('tech-1', 2)
      ..completeLesson('tech-2', 1);

    expect(state.totalMinutes, 14);
  });

  test('salva tentativas e consulta última e melhor tentativa', () {
    final state = AppState();
    final olderAttempt = QuizAttempt(
      lessonId: 'tech-1',
      selectedAnswers: const <int, int>{0: 0},
      score: 1,
      finishedAt: DateTime(2026),
    );
    final newerAttempt = QuizAttempt(
      lessonId: 'tech-1',
      selectedAnswers: const <int, int>{0: 1, 1: 1},
      score: 2,
      finishedAt: DateTime(2026, 1, 2),
    );

    state
      ..saveQuizAttempt(olderAttempt)
      ..saveQuizAttempt(newerAttempt);

    expect(state.completedLessons, contains('tech-1'));
    expect(state.quizScores['tech-1'], 2);
    expect(state.quizAttempts['tech-1'], hasLength(2));
    expect(state.latestQuizAttempt('tech-1'), newerAttempt);
    expect(state.bestQuizAttempt('tech-1'), newerAttempt);
  });

}
