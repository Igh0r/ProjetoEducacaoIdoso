import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('controla avanço de passos e transição para quiz', () {
    final lesson = lessonRepository.findById('tech-1')!;
    final controller = LessonSessionController(lesson);

    controller
      ..goToNextStep()
      ..goToNextStep()
      ..goToNextStep();

    expect(controller.phase, LessonPhase.quizIntro);
  });

  test('registra resposta, pontuação e tentativa de quiz', () {
    final lesson = lessonRepository.findById('tech-1')!;
    final controller = LessonSessionController(lesson)..startQuiz();

    controller.selectAnswer(lesson.quiz.first.correct);
    controller.goToNextQuestion();
    controller.selectAnswer(lesson.quiz[1].correct);
    controller.goToNextQuestion();

    final attempt = controller.buildAttempt();
    expect(controller.phase, LessonPhase.done);
    expect(attempt.score, lesson.quiz.length);
    expect(attempt.selectedAnswers.length, lesson.quiz.length);
  });
}
