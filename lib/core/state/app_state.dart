part of 'package:educacao_idoso/main.dart';

class AppState extends ChangeNotifier {
  AppState({
    ProgressRepository? progressRepository,
    ProgressService? progressService,
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
  int get totalLessons => _progressService.totalLessons();
  int get totalMinutes => _progressService.totalMinutes(completedLessons);

  void completeLesson(String id, int score) {
    _progressRepository.completeLesson(id, score);
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
}

final appState = AppState();
