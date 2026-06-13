import 'dart:convert';
import 'package:flutter/services.dart';
import '../Models/question.dart';

class QuestionService {
  static Future<List<Question>> loadQuestions(String subject) async {
    final sub = subject.toLowerCase();
    final candidates = [
      'lib/data/questions/$sub.json',
      'assets/data/questions/$sub.json',
      'assets/lib/data/questions/$sub.json',
    ];

    for (final path in candidates) {
      try {
        final String data = await rootBundle.loadString(path);
        final List<dynamic> jsonList = json.decode(data);
        return jsonList
            .map((item) => Question.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (_) {
        // try next path
      }
    }

    // If all fail, return empty list
    return [];
  }
}
