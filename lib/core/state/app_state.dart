part of 'package:educacao_idoso/main.dart';

class AppState extends ChangeNotifier {
  AppState({
    ProgressRepository? progressRepository,
    ProgressService? progressService,
    AccessibilitySettings? accessibilitySettings,
  })  : _progressRepository = progressRepository ?? InMemoryProgressRepository(),
        _progressService = progressService ?? progressServiceDefault,
        _accessibilitySettings = accessibilitySettings ?? const AccessibilitySettings();

  final ProgressRepository _progressRepository;
  final ProgressService _progressService;
  AccessibilitySettings _accessibilitySettings;

  AccessibilitySettings get accessibilitySettings => _accessibilitySettings;
  double get textScale => _accessibilitySettings.textScale;
  bool get highContrast => _accessibilitySettings.highContrast;
  Set<String> get completedLessons => _progressRepository.getCompletedLessons();
  Map<String, int> get quizScores => _progressRepository.getQuizScores();
  int get totalLessons => _progressService.totalLessons();
  int get totalMinutes => _progressService.totalMinutes(completedLessons);

  void completeLesson(String id, int score) {
    _progressRepository.completeLesson(id, score);
    notifyListeners();
  }

  void toggleContrast() {
    _accessibilitySettings = _accessibilitySettings.copyWith(highContrast: !highContrast);
    notifyListeners();
  }

  void setTextScale(double value) {
    _accessibilitySettings = _accessibilitySettings.copyWith(textScale: value);
    notifyListeners();
  }

  void updateAccessibility(AccessibilitySettings settings) {
    _accessibilitySettings = settings;
    notifyListeners();
  }
}

final appState = AppState();
