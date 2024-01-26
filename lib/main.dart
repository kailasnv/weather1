import 'package:flutter/material.dart';
import 'package:weather1/presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather1',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
