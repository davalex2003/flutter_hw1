import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    bodyMedium:
        TextStyle(fontFamily: 'Roboto', fontSize: 15.0, color: Colors.black),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    bodyMedium:
        TextStyle(fontFamily: 'Roboto', fontSize: 15.0, color: Colors.white),
  ),
);
