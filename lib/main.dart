import 'package:flutter/material.dart';
import 'package:todone_app/pages/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
        brightness: MediaQuery.platformBrightnessOf(context),
        seedColor: const Color.fromRGBO(0, 186, 186, 100));
    return MaterialApp(
      title: 'ToDone App',
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
      home: const Home(),
    );
  }
}
