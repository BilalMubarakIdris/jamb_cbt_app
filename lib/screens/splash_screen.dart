import 'package:flutter/material.dart';
import 'dart:async';
import 'registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToRegistration();
  }

  Future<void> _navigateToRegistration() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'JAMB CBT App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Science Practice',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 6),
            const Text(
              'Created by Hassan Muhammad Bello',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 2),
            const Text(
              'Reg. No.: 221030678',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
