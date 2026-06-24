part of 'package:educacao_idoso/main.dart';

class AppState extends ChangeNotifier {
  AppState({
    ProgressRepository? progressRepository,
    ProgressService? progressService,
  })  : _progressRepository = progressRepository ?? InMemoryProgressRepository(),
        _progressService = progressService ?? progressServiceDefault;

  final ProgressRepository _progressRepository;
  final ProgressService _progressService;
  double textScale = 1;
  bool highContrast = true;

  Set<String> get completedLessons => _progressRepository.getCompletedLessons();
  Map<String, int> get quizScores => _progressRepository.getQuizScores();
  Map<String, DateTime> get completionDates => _progressRepository.getCompletionDates();
  int get totalLessons => _progressService.totalLessons();
  int get totalMinutes => _progressService.totalMinutes(completedLessons);
  List<ProgressAchievement> get achievements => _progressService.achievements(completedLessons, quizScores);
  List<ReviewSuggestion> get reviewSuggestions => _progressService.reviewSuggestions(completedLessons, quizScores);
  Lesson? get nextLesson => _progressService.nextLesson(completedLessons);
  List<ProgressHistoryItem> get chronologicalHistory => _progressService.chronologicalHistory(completedLessons, quizScores, completionDates);

  void completeLesson(String id, int score) {
    _progressRepository.completeLesson(id, score);
    notifyListeners();
  }

  void toggleContrast() {
    highContrast = !highContrast;
    notifyListeners();
  }

  void setTextScale(double value) {
    textScale = value;
    notifyListeners();
  }
}

final appState = AppState();
