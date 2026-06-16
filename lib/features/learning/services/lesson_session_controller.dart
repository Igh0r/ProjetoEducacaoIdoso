part of 'package:educacao_idoso/main.dart';

class LessonSessionController extends ChangeNotifier {
  LessonSessionController(this.lesson);

  final Lesson lesson;
  int currentStep = 0;
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;
  LessonPhase phase = LessonPhase.steps;
  final Map<int, int> selectedAnswers = <int, int>{};

  bool get isLastStep => currentStep == lesson.steps.length - 1;
  bool get isLastQuestion => currentQuestion == lesson.quiz.length - 1;
  LessonStep get step => lesson.steps[currentStep];
  QuizQuestion get question => lesson.quiz[currentQuestion];

  void goToNextStep() {
    if (isLastStep) {
      phase = LessonPhase.quizIntro;
    } else {
      currentStep++;
    }
    notifyListeners();
  }

  void goToPreviousStep() {
    if (currentStep > 0) currentStep--;
    notifyListeners();
  }

  void startQuiz() {
    phase = LessonPhase.quiz;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (selectedAnswer != null) return;
    selectedAnswer = index;
    selectedAnswers[currentQuestion] = index;
    if (index == question.correct) score++;
    notifyListeners();
  }

  void goToNextQuestion() {
    if (isLastQuestion) {
      phase = LessonPhase.done;
    } else {
      currentQuestion++;
      selectedAnswer = null;
    }
    notifyListeners();
  }

  void skipQuiz() {
    phase = LessonPhase.done;
    notifyListeners();
  }

  QuizAttempt buildAttempt() => QuizAttempt(
        lessonId: lesson.id,
        selectedAnswers: Map.unmodifiable(selectedAnswers),
        score: score,
        finishedAt: DateTime.now(),
      );
}
