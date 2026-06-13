import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import 'combination_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _controller = TextEditingController();
  String error = "";

  // Validation: JAMB format (10-12 digits, optionally followed by 0-2 letters)
  bool validateJamb(String value) {
    return RegExp(r'^\d{10,12}[A-Z]{0,2}$').hasMatch(value);
  }

  void proceed() {
    final provider = Provider.of<ExamProvider>(context, listen: false);
    final input = _controller.text.trim().toUpperCase();

    if (input.isEmpty) {
      setState(() => error = "Please enter your JAMB registration number");
      return;
    }

    if (!validateJamb(input)) {
      setState(
        () => error =
            "Invalid JAMB number format (10-12 digits + optional 0-2 letters)",
      );
      return;
    }

    provider.setJambNumber(input);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CombinationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  "JAMB CBT Practice App",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Offline Science Examination",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Created by Hassan Muhammad Bello",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Reg. No.: 221030678",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "JAMB Registration Number",
                    hintText: "e.g. 1234567890AB",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.numbers),
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
                const SizedBox(height: 10),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: proceed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
