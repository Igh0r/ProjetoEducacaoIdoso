import 'package:flutter/foundation.dart';
import 'package:educacao_idoso/features/progress/repositories/progress_repository.dart';
import 'package:educacao_idoso/features/progress/services/progress_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    ProgressRepository? progressRepository,
    ProgressService? progressService,
    ProfileRepository? profileRepository,
  })  : _progressRepository = progressRepository ?? InMemoryProgressRepository(),
        _progressService = progressService ?? progressServiceDefault,
        _profileRepository = profileRepository ?? LocalProfileRepository() {
    userProfile = _profileRepository.loadProfile();
  }

  final ProgressRepository _progressRepository;
  final ProgressService _progressService;
  final ProfileRepository _profileRepository;
  double textScale = 1;
  bool highContrast = true;
  UserProfile userProfile = const UserProfile();

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

  Future<void> saveUserProfile(UserProfile profile) async {
    userProfile = profile;
    notifyListeners();
    await _profileRepository.saveProfile(profile);
  }
}

AppState appState = AppState();
