import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import '../Models/combination_model.dart';
import 'exam_screen.dart';

class CombinationScreen extends StatefulWidget {
  const CombinationScreen({super.key});

  @override
  State<CombinationScreen> createState() => _CombinationScreenState();
}

class _CombinationScreenState extends State<CombinationScreen> {
  String? selectedCombination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Science Combination'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Your Science Combination',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'English is automatically included in all combinations',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scienceCombinations.length,
              itemBuilder: (context, index) {
                final combo = scienceCombinations[index];
                final isSelected = selectedCombination == combo.title;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedCombination = combo.title);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    color: isSelected ? Colors.green.shade100 : Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        combo.title,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(combo.subjects.join(', ')),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedCombination == null
                    ? null
                    : () {
                        final provider = Provider.of<ExamProvider>(
                          context,
                          listen: false,
                        );
                        provider.setCombination(
                          selectedCombination!.toLowerCase(),
                        );
                        provider.resetExam();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ExamScreen()),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Start Examination',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
