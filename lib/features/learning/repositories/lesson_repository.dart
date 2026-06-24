import 'package:educacao_idoso/features/learning/data/lesson_seed_data.dart';
import 'package:educacao_idoso/features/learning/models/learning_models.dart';

Lesson? lessonById(String id) {
  for (final category in learningTracks) {
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
  List<LessonCategory> getCategories() => learningTracks;

  @override
  Lesson? findById(String id) => lessonById(id);
}

const lessonRepository = InMemoryLessonRepository();
