import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import 'combination_screen.dart';
import 'registration_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExamProvider>(context);

    final total = provider.questions.length;
    final correct = provider.score;
    final incorrect = total - correct;
    final percentage = total == 0
        ? '0.00'
        : ((correct / total) * 100).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Examination Result'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Trophy Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.shade100,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 60,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Examination Completed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'Your Score: $percentage%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: double.parse(percentage) >= 50
                      ? Colors.green
                      : Colors.red,
                ),
              ),

              const SizedBox(height: 40),

              // Result Cards
              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.blue),
                  title: const Text('Total Questions'),
                  trailing: Text(
                    '$total',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Correct Answers'),
                  trailing: Text(
                    '$correct',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.cancel, color: Colors.red),
                  title: const Text('Incorrect Answers'),
                  trailing: Text(
                    '$incorrect',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.percent, color: Colors.purple),
                  title: const Text('Percentage Score'),
                  trailing: Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    provider.resetExam();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CombinationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Retake Examination',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    provider.resetExam();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegistrationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Return Home',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 12),
              const Text(
                'Created by Hassan Muhammad Bello • Reg. No.: 221030678',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
