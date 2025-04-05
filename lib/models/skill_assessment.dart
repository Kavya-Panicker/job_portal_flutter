import 'package:flutter/material.dart';

enum QuestionType {
  multipleChoice,
  coding,
  written,
  aptitude
}

class Question {
  final String id;
  final String question;
  final QuestionType type;
  final List<String> options;
  final String correctAnswer;
  final int points;
  final String? codeTemplate; // For coding questions
  final List<String>? testCases; // For coding questions

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.points,
    this.codeTemplate,
    this.testCases,
  });
}

class SkillAssessment {
  final String id;
  final String title;
  final String domain;
  final String description;
  final int timeLimit; // in minutes
  final int totalPoints;
  final List<Question> questions;
  final String difficulty; // easy, medium, hard
  final Map<String, String> localizedTitles; // For multilingual support

  SkillAssessment({
    required this.id,
    required this.title,
    required this.domain,
    required this.description,
    required this.timeLimit,
    required this.totalPoints,
    required this.questions,
    required this.difficulty,
    required this.localizedTitles,
  });
}

class AssessmentResult {
  final String userId;
  final String assessmentId;
  final int score;
  final int totalPoints;
  final Duration timeTaken;
  final DateTime completedAt;
  final Map<String, String> answers;
  final bool passed;

  AssessmentResult({
    required this.userId,
    required this.assessmentId,
    required this.score,
    required this.totalPoints,
    required this.timeTaken,
    required this.completedAt,
    required this.answers,
    required this.passed,
  });

  double get percentageScore => (score / totalPoints) * 100;
} 