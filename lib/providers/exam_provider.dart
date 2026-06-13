import 'dart:async';
import 'package:flutter/material.dart';
import '../Models/question.dart';

class ExamProvider extends ChangeNotifier {
  // Registration
  String jambNumber = "";

  // Combination
  String selectedCombination = "";

  // Questions
  List<Question> questions = [];

  // Exam state
  int currentIndex = 0;
  int score = 0;
  bool examSubmitted = false;

  // Timer
  int remainingSeconds = 60 * 60; // 1 hour
  Timer? _timer;

  // Answers (questionId -> optionIndex)
  Map<int, int> selectedAnswers = {};

  // Callback when time expires
  VoidCallback? onTimeExpired;

  void setJambNumber(String value) {
    jambNumber = value;
    notifyListeners();
  }

  void setCombination(String value) {
    selectedCombination = value;
    notifyListeners();
  }

  void setQuestions(List<Question> data) {
    questions = data;
    notifyListeners();
  }

  void startExamTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        // Time expired - auto-submit
        timer.cancel();
        submitExam();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    notifyListeners();
  }

  void calculateScore() {
    score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    notifyListeners();
  }

  void submitExam() {
    stopTimer();
    calculateScore();
    examSubmitted = true;
    notifyListeners();
  }

  void resetExam() {
    currentIndex = 0;
    score = 0;
    selectedAnswers.clear();
    remainingSeconds = 60 * 60;
    examSubmitted = false;
    stopTimer();
    notifyListeners();
  }
}
