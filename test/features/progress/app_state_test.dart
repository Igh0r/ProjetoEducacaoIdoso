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
}
