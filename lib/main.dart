import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/exam_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CBTApp());
}

class CBTApp extends StatelessWidget {
  const CBTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ExamProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JAMB CBT App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
