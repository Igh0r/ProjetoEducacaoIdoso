import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('todas as categorias possuem pelo menos uma aula', () {
    expect(categories, isNotEmpty);
    for (final category in categories) {
      expect(category.lessons, isNotEmpty, reason: category.id);
    }
  });

  test('todos os ids de aulas são únicos', () {
    expect(LessonUtils.hasUniqueLessonIds(categories), isTrue);
  });

  test('trilhas principais estão disponíveis', () {
    expect(learningTracks.map((track) => track.name), containsAll(['Primeiros passos', 'Segurança digital', 'Serviços públicos', 'Finanças digitais', 'Comunicação']));
    expect(learningTracks.every((track) => track.lessons.isNotEmpty), isTrue);
  });

  test('cada aula possui passos e quiz', () {
    for (final category in categories) {
      for (final lesson in category.lessons) {
        expect(LessonUtils.hasCompleteLearningContent(lesson), isTrue, reason: lesson.id);
      }
    }
  });

  test('pré-requisitos apontam para ids de aulas existentes', () {
    expect(LessonUtils.hasKnownPrerequisites(categories), isTrue);
  });

  test('recomendação respeita pré-requisitos concluídos', () {
    expect(LessonUtils.nextRecommendedLesson(categories, const {})?.id, 'tech-1');
    expect(LessonUtils.isUnlocked(lessonRepository.findById('tech-2')!, {'tech-1'}), isTrue);
    expect(LessonUtils.isUnlocked(lessonRepository.findById('tech-3')!, {'tech-1'}), isFalse);
  });

  test('repository local encontra aula por id', () {
    expect(lessonRepository.findById('tech-1')?.title, 'Como usar o WhatsApp');
    expect(lessonRepository.findById('inexistente'), isNull);
  });
}
