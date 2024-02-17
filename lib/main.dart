import 'package:flutter/material.dart';
import 'package:hw1/pages/home.dart';
import 'package:hw1/providers/themes_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Davidenko News',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Home(),
    );
  }
}
