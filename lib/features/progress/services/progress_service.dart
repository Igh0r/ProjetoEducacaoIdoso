part of 'package:educacao_idoso/main.dart';

class ProgressService {
  const ProgressService(this.lessonRepository);

  final LessonRepository lessonRepository;

  int totalLessons() => lessonRepository.getCategories().fold(0, (sum, category) => sum + category.lessons.length);

  int totalMinutes(Set<String> completedLessonIds) => completedLessonIds.fold(0, (sum, id) {
        final lesson = lessonRepository.findById(id);
        return sum + (lesson?.minutes ?? 0);
      });
}

const progressServiceDefault = ProgressService(lessonRepository);
