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
  Map<String, List<QuizAttempt>> get quizAttempts => _progressRepository.getQuizAttempts();
  int get totalLessons => _progressService.totalLessons();
  int get totalMinutes => _progressService.totalMinutes(completedLessons);

  QuizAttempt? latestQuizAttempt(String lessonId) => _progressRepository.getLatestQuizAttempt(lessonId);

  QuizAttempt? bestQuizAttempt(String lessonId) => _progressRepository.getBestQuizAttempt(lessonId);

  void completeLesson(String id, int score) {
    _progressRepository.completeLesson(id, score);
    notifyListeners();
  }

  void saveQuizAttempt(QuizAttempt attempt) {
    _progressRepository.saveQuizAttempt(attempt);
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
