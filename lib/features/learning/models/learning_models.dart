import 'package:flutter/material.dart';

enum LessonPhase { steps, quizIntro, quiz, done }

class LessonCategory {
  const LessonCategory(this.id, this.name, this.emoji, this.color, this.description, this.lessons);
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final String description;
  final List<Lesson> lessons;
}

class Lesson {
  const Lesson({required this.id, required this.title, required this.description, required this.emoji, required this.duration, required this.difficulty, required this.minutes, required this.steps, required this.quiz});
  final String id;
  final String title;
  final String description;
  final String emoji;
  final String duration;
  final String difficulty;
  final int minutes;
  final List<LessonStep> steps;
  final List<QuizQuestion> quiz;
}

class LessonStep {
  const LessonStep(this.title, this.content, this.emoji, {this.tip, this.warning});
  final String title;
  final String content;
  final String emoji;
  final String? tip;
  final String? warning;
}

class QuizQuestion {
  const QuizQuestion(this.question, this.options, this.correct, this.explanation);
  final String question;
  final List<String> options;
  final int correct;
  final String explanation;
}

