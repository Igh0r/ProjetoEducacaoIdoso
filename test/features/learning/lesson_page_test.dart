import 'package:educacao_idoso/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LessonPage segue o fluxo completo validado pelo controller', (tester) async {
    final lesson = lessonRepository.findById('tech-1')!;
    final expectedController = LessonSessionController(lesson);

    await tester.pumpWidget(MaterialApp(home: LessonPage(lesson: lesson)));

    for (var i = 0; i < lesson.steps.length - 1; i++) {
      expectedController.goToNextStep();
      await tester.tap(find.text('Próximo'));
      await tester.pumpAndSettle();
      expect(find.text('Passo ${expectedController.currentStep + 1} de ${lesson.steps.length}'), findsOneWidget);
    }

    expectedController.goToNextStep();
    await tester.tap(find.text('Fazer quiz'));
    await tester.pumpAndSettle();
    expect(expectedController.phase, LessonPhase.quizIntro);
    expect(find.text('🧠 Hora do quiz!'), findsOneWidget);

    expectedController.startQuiz();
    await tester.tap(find.text('Começar quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Quiz 1/${lesson.quiz.length}'), findsOneWidget);

    for (var i = 0; i < lesson.quiz.length; i++) {
      final question = lesson.quiz[i];
      expectedController.selectAnswer(question.correct);
      await tester.tap(find.text(question.options[question.correct]));
      await tester.pumpAndSettle();
      expect(find.text(question.explanation), findsOneWidget);

      expectedController.goToNextQuestion();
      final nextButton = i == lesson.quiz.length - 1 ? 'Ver resultado' : 'Próxima pergunta';
      await tester.tap(find.text(nextButton));
      await tester.pumpAndSettle();
    }

    expect(expectedController.phase, LessonPhase.done);
    expect(find.text('Aula concluída!'), findsOneWidget);
    expect(find.text('Resultado do quiz: ${expectedController.score}/${lesson.quiz.length}'), findsOneWidget);
    expect(appState.completedLessons, contains(lesson.id));
    expect(appState.quizScores[lesson.id], expectedController.score);
  });

  testWidgets('LessonPage conclui aula ao pular o quiz com pontuação zero', (tester) async {
    final lesson = lessonRepository.findById('tech-2')!;
    final expectedController = LessonSessionController(lesson);

    await tester.pumpWidget(MaterialApp(home: LessonPage(lesson: lesson)));

    for (var i = 0; i < lesson.steps.length; i++) {
      expectedController.goToNextStep();
      await tester.tap(find.text(i == lesson.steps.length - 1 ? 'Fazer quiz' : 'Próximo'));
      await tester.pumpAndSettle();
    }

    expectedController.skipQuiz();
    await tester.tap(find.text('Pular quiz e concluir'));
    await tester.pumpAndSettle();

    expect(expectedController.phase, LessonPhase.done);
    expect(find.text('Aula concluída!'), findsOneWidget);
    expect(find.text('Resultado do quiz: 0/${lesson.quiz.length}'), findsOneWidget);
    expect(appState.completedLessons, contains(lesson.id));
    expect(appState.quizScores[lesson.id], 0);
  });
}
