part of 'package:educacao_idoso/main.dart';

class LessonUtils {
  const LessonUtils._();

  static const trackNames = <String, String>{
    'primeiros-passos': 'Primeiros passos',
    'seguranca-digital': 'Segurança digital',
    'servicos-publicos': 'Serviços públicos',
    'financas-digitais': 'Finanças digitais',
    'comunicacao': 'Comunicação',
  };

  static Iterable<Lesson> allLessons(List<LessonCategory> categories) => categories.expand((category) => category.lessons);

  static String trackName(String trackId) => trackNames[trackId] ?? trackId;

  static bool hasUniqueLessonIds(List<LessonCategory> categories) {
    final ids = <String>{};
    for (final lesson in allLessons(categories)) {
      if (!ids.add(lesson.id)) return false;
    }
    return true;
  }

  static bool hasCompleteLearningContent(Lesson lesson) => lesson.steps.isNotEmpty && lesson.quiz.isNotEmpty;

  static bool hasKnownPrerequisites(List<LessonCategory> categories) {
    final ids = allLessons(categories).map((lesson) => lesson.id).toSet();
    return allLessons(categories).every((lesson) => lesson.prerequisites.every(ids.contains));
  }

  static bool isUnlocked(Lesson lesson, Set<String> completedLessonIds) => lesson.prerequisites.every(completedLessonIds.contains);

  static List<String> missingPrerequisites(Lesson lesson, Set<String> completedLessonIds) => lesson.prerequisites.where((id) => !completedLessonIds.contains(id)).toList();

  static Lesson? nextRecommendedLesson(List<LessonCategory> categories, Set<String> completedLessonIds) {
    final available = allLessons(categories)
        .where((lesson) => !completedLessonIds.contains(lesson.id))
        .where((lesson) => isUnlocked(lesson, completedLessonIds))
        .toList()
      ..sort((a, b) {
        final score = a.estimatedDifficultyScore.compareTo(b.estimatedDifficultyScore);
        if (score != 0) return score;
        return a.minutes.compareTo(b.minutes);
      });
    return available.isEmpty ? null : available.first;
  }
}
