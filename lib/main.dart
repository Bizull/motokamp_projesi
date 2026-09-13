import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MotoKampApp());
}

class MotoKampApp extends StatelessWidget {
  const MotoKampApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoKamp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}