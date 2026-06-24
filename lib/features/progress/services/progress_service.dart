import 'package:educacao_idoso/features/learning/models/learning_models.dart';
import 'package:educacao_idoso/features/learning/repositories/lesson_repository.dart';

class ProgressService {
  const ProgressService(this.lessonRepository);

  final LessonRepository lessonRepository;

  int totalLessons() => lessonRepository.getCategories().fold(0, (sum, category) => sum + category.lessons.length);

  int totalMinutes(Set<String> completedLessonIds) => completedLessonIds.fold(0, (sum, id) {
        final lesson = lessonRepository.findById(id);
        return sum + (lesson?.minutes ?? 0);
      });

  List<ProgressAchievement> achievements(Set<String> completedLessonIds, Map<String, int> quizScores) {
    final completed = completedLessonIds.map(lessonRepository.findById).whereType<Lesson>().toList();
    final securityLessons = _securityLessons();
    final completedSecurityLessons = securityLessons.where((lesson) => completedLessonIds.contains(lesson.id)).length;
    final perfectQuiz = completed.any((lesson) => (quizScores[lesson.id] ?? 0) == lesson.quiz.length && lesson.quiz.isNotEmpty);

    return [
      ProgressAchievement(
        icon: '🥇',
        title: 'Primeira aula',
        description: 'Conclua sua primeira aula.',
        unlocked: completedLessonIds.isNotEmpty,
      ),
      ProgressAchievement(
        icon: '🏆',
        title: 'Três aulas',
        description: 'Complete 3 aulas para firmar o hábito.',
        unlocked: completedLessonIds.length >= 3,
        progressText: '${completedLessonIds.length.clamp(0, 3)}/3',
      ),
      ProgressAchievement(
        icon: '🛡️',
        title: 'Segurança digital',
        description: 'Finalize as aulas sobre golpes, PIX, gov.br e banco.',
        unlocked: securityLessons.isNotEmpty && completedSecurityLessons == securityLessons.length,
        progressText: '$completedSecurityLessons/${securityLessons.length}',
      ),
      ProgressAchievement(
        icon: '💯',
        title: 'Quiz perfeito',
        description: 'Acerte todas as perguntas de um quiz.',
        unlocked: perfectQuiz,
      ),
    ];
  }

  List<ReviewSuggestion> reviewSuggestions(Set<String> completedLessonIds, Map<String, int> quizScores, {int limit = 3}) {
    final suggestions = <ReviewSuggestion>[];

    for (final category in lessonRepository.getCategories()) {
      final completedLessons = category.lessons.where((lesson) => completedLessonIds.contains(lesson.id) && lesson.quiz.isNotEmpty).toList();
      if (completedLessons.isEmpty) continue;

      final score = completedLessons.fold<int>(0, (sum, lesson) => sum + (quizScores[lesson.id] ?? 0));
      final total = completedLessons.fold<int>(0, (sum, lesson) => sum + lesson.quiz.length);
      final weakestLesson = completedLessons.reduce((current, next) {
        final currentPercent = (quizScores[current.id] ?? 0) / current.quiz.length;
        final nextPercent = (quizScores[next.id] ?? 0) / next.quiz.length;
        return nextPercent < currentPercent ? next : current;
      });

      suggestions.add(ReviewSuggestion(category: category, lesson: weakestLesson, score: score, total: total));
    }

    suggestions
      ..sort((a, b) {
        final scoreCompare = a.percent.compareTo(b.percent);
        if (scoreCompare != 0) return scoreCompare;
        return a.category.name.compareTo(b.category.name);
      });

    return suggestions.where((suggestion) => suggestion.score < suggestion.total).take(limit).toList();
  }

  Lesson? nextLesson(Set<String> completedLessonIds) {
    for (final category in lessonRepository.getCategories()) {
      for (final lesson in category.lessons) {
        if (!completedLessonIds.contains(lesson.id)) return lesson;
      }
    }
    return null;
  }

  List<ProgressHistoryItem> chronologicalHistory(Set<String> completedLessonIds, Map<String, int> quizScores, Map<String, DateTime> completionDates) {
    final items = completedLessonIds.map(lessonRepository.findById).whereType<Lesson>().map((lesson) {
      return ProgressHistoryItem(
        lesson: lesson,
        score: quizScores[lesson.id] ?? 0,
        completedAt: completionDates[lesson.id],
      );
    }).toList()
      ..sort((a, b) => (b.completedAt ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(a.completedAt ?? DateTime.fromMillisecondsSinceEpoch(0)));
    return items;
  }

  List<Lesson> _securityLessons() => lessonRepository
      .getCategories()
      .expand((category) => category.lessons)
      .where((lesson) => const {'tech-3', 'tech-4', 'citizen-5', 'finance-2'}.contains(lesson.id))
      .toList();
}

const progressServiceDefault = ProgressService(lessonRepository);

class ProgressAchievement {
  const ProgressAchievement({required this.icon, required this.title, required this.description, required this.unlocked, this.progressText});

  final String icon;
  final String title;
  final String description;
  final bool unlocked;
  final String? progressText;
}

class ReviewSuggestion {
  const ReviewSuggestion({required this.category, required this.lesson, required this.score, required this.total});

  final LessonCategory category;
  final Lesson lesson;
  final int score;
  final int total;

  double get percent => total == 0 ? 1 : score / total;
}

class ProgressHistoryItem {
  const ProgressHistoryItem({required this.lesson, required this.score, required this.completedAt});

  final Lesson lesson;
  final int score;
  final DateTime? completedAt;
}
