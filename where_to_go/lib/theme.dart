import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 49, 140, 231), // Tło ekranu

  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 170, 8, 57), // Pasek górny
    foregroundColor: Colors.white, // Kolor tekstu w pasku górnym
  ),

  cardTheme: const CardThemeData(
    color: Color.fromARGB(255, 49, 140, 231),
  ),

  colorScheme: const ColorScheme.light(
    secondary: Color.fromARGB(255, 221, 172, 50),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // kolor napisów karty
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 19, 54, 90), // Tło ekranu

  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 85, 5, 29), // Pasek górny
    foregroundColor: Colors.white, // Kolor tekstu w pasku górnym
  ),

  cardTheme: const CardThemeData(
    color: Color.fromARGB(255, 19, 54, 90),
  ),

  // Zmiana na ColorScheme.dark rozwiązuje czerwony ekran!
  colorScheme: const ColorScheme.dark(
    secondary: Color.fromARGB(255, 132, 97, 8),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // kolor napisów karty
  ),
);