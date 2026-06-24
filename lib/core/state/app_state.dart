import 'package:flutter/foundation.dart';
import 'package:educacao_idoso/features/progress/repositories/progress_repository.dart';
import 'package:educacao_idoso/features/progress/services/progress_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    ProgressRepository? progressRepository,
    ProgressService? progressService,
    ProfileRepository? profileRepository,
  })  : _progressRepository = progressRepository ?? InMemoryProgressRepository(),
        _progressService = progressService ?? progressServiceDefault {
    accessibilitySettings = _progressRepository.getAccessibilitySettings();
  }

  final ProgressRepository _progressRepository;
  final ProgressService _progressService;
  late AccessibilitySettings accessibilitySettings;

  double get textScale => accessibilitySettings.textScale;
  bool get highContrast => accessibilitySettings.highContrast;

  Set<String> get completedLessons => _progressRepository.getCompletedLessons();
  Map<String, int> get quizScores => _progressRepository.getQuizScores();
  Map<String, List<QuizAttempt>> get quizAttempts => _progressRepository.getQuizAttempts();
  int get totalLessons => _progressService.totalLessons();
  int get totalMinutes => _progressService.totalMinutes(completedLessons);
  List<ProgressAchievement> get achievements => _progressService.achievements(completedLessons, quizScores);
  List<ReviewSuggestion> get reviewSuggestions => _progressService.reviewSuggestions(completedLessons, quizScores);
  Lesson? get nextLesson => _progressService.nextLesson(completedLessons);
  List<ProgressHistoryItem> get chronologicalHistory => _progressService.chronologicalHistory(completedLessons, quizScores, completionDates);

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
    updateAccessibilitySettings(accessibilitySettings.copyWith(highContrast: !highContrast));
  }

  void setTextScale(double value) {
    updateAccessibilitySettings(accessibilitySettings.copyWith(textScale: value));
  }

  void setLowLightTheme(bool value) {
    updateAccessibilitySettings(accessibilitySettings.copyWith(lowLightTheme: value));
  }

  void setButtonScale(double value) {
    updateAccessibilitySettings(accessibilitySettings.copyWith(buttonScale: value));
  }

  void setContentSpacing(double value) {
    updateAccessibilitySettings(accessibilitySettings.copyWith(contentSpacing: value));
  }

  void setDyslexiaFriendlyFont(bool value) {
    updateAccessibilitySettings(accessibilitySettings.copyWith(dyslexiaFriendlyFont: value));
  }

  void updateAccessibilitySettings(AccessibilitySettings settings) {
    accessibilitySettings = settings;
    _progressRepository.saveAccessibilitySettings(settings);
    notifyListeners();
  }

  void toggleReadAloud() {
    readAloudEnabled = !readAloudEnabled;
    notifyListeners();
  }
}

AppState appState = AppState();
