import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 49, 140, 231),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 170, 8, 57),
    foregroundColor: Colors.white,
  ),

  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB (255, 170, 8, 57), // np. pasek/akcent główny
    secondary: Color.fromARGB(255, 221, 172, 50), // akcent pomocniczy
    surface: Color.fromARGB(255, 49, 140, 231), // np. tło kart/paneli
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 19, 54, 90),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 85, 5, 29),
    foregroundColor: Colors.white,
  ),

  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 85, 5, 29),
    secondary: Color.fromARGB(255, 132, 97, 8),
    surface: Color.fromARGB(255, 19, 54, 90),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);