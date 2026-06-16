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

  test('cada aula possui passos e quiz', () {
    for (final category in categories) {
      for (final lesson in category.lessons) {
        expect(LessonUtils.hasCompleteLearningContent(lesson), isTrue, reason: lesson.id);
      }
    }
  });

  test('repository local encontra aula por id', () {
    expect(lessonRepository.findById('tech-1')?.title, 'Como usar o WhatsApp');
    expect(lessonRepository.findById('inexistente'), isNull);
  });
}
