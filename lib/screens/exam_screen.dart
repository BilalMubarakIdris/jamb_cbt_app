import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import '../services/question_service.dart';
import '../Models/combination_model.dart';
import '../Models/question.dart';
import 'result_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final provider = Provider.of<ExamProvider>(context, listen: false);

    // Find the selected combination
    final combo = scienceCombinations.firstWhere(
      (c) => c.title.toLowerCase() == provider.selectedCombination,
      orElse: () => scienceCombinations[0],
    );

    // Load questions for all subjects in the combination
    List<Question> allQuestions = [];
    for (final subject in combo.subjects) {
      final questions = await QuestionService.loadQuestions(subject);
      allQuestions.addAll(questions);
    }

    provider.setQuestions(allQuestions);
    provider.startExamTimer();

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  void _submitExam() {
    final provider = Provider.of<ExamProvider>(context, listen: false);
    provider.submitExam();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ResultScreen()),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<ExamProvider>(
        builder: (context, provider, _) {
          if (isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.questions.isEmpty) {
            return Scaffold(
              appBar: AppBar(title: const Text('Examination')),
              body: const Center(child: Text('No questions available')),
            );
          }

          final question = provider.questions[provider.currentIndex];
          final isFirstQuestion = provider.currentIndex == 0;
          final isLastQuestion =
              provider.currentIndex == provider.questions.length - 1;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Q${provider.currentIndex + 1}/${provider.questions.length}',
              ),
              backgroundColor: Colors.green,
              elevation: 0,
            ),
            body: Column(
              children: [
                // Timer Bar
                Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Time Remaining:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatTime(provider.remainingSeconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Question Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question Text
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Options
                        ...List.generate(question.options.length, (index) {
                          final isSelected =
                              provider.selectedAnswers[provider.currentIndex] ==
                              index;
                          return GestureDetector(
                            onTap: () {
                              provider.selectAnswer(
                                provider.currentIndex,
                                index,
                              );
                            },
                            child: Card(
                              color: isSelected
                                  ? Colors.green.shade100
                                  : Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Colors.green
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(
                                            65 + index,
                                          ), // A, B, C, D
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        question.options[index],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: isFirstQuestion
                              ? null
                              : () => provider.previousQuestion(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: isLastQuestion
                              ? _submitExam
                              : () => provider.nextQuestion(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isLastQuestion
                                ? Colors.red
                                : Colors.green,
                          ),
                          child: Text(isLastQuestion ? 'Submit' : 'Next'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    final provider = Provider.of<ExamProvider>(context, listen: false);
    provider.stopTimer();
    super.dispose();
  }
}
