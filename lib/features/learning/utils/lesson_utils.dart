import 'package:educacao_idoso/features/learning/models/learning_models.dart';

class LessonUtils {
  const LessonUtils._();

  static Iterable<Lesson> allLessons(List<LessonCategory> categories) => categories.expand((category) => category.lessons);

  static bool hasUniqueLessonIds(List<LessonCategory> categories) {
    final ids = <String>{};
    for (final lesson in allLessons(categories)) {
      if (!ids.add(lesson.id)) return false;
    }
    return true;
  }

  static bool hasCompleteLearningContent(Lesson lesson) => lesson.steps.isNotEmpty && lesson.quiz.isNotEmpty;
}
