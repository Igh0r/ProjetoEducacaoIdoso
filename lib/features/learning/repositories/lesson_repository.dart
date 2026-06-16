part of 'package:educacao_idoso/main.dart';

Lesson? lessonById(String id) {
  for (final category in categories) {
    for (final lesson in category.lessons) {
      if (lesson.id == id) return lesson;
    }
  }
  return null;
}

abstract class LessonRepository {
  List<LessonCategory> getCategories();
  Lesson? findById(String id);
}

class InMemoryLessonRepository implements LessonRepository {
  const InMemoryLessonRepository();

  @override
  List<LessonCategory> getCategories() => categories;

  @override
  Lesson? findById(String id) => lessonById(id);
}

const lessonRepository = InMemoryLessonRepository();
