import 'package:flutter/material.dart';

final ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 36, 119, 105),
  cardTheme: CardThemeData(
    color: Colors.amber,
    shadowColor: const Color.fromARGB(255, 68, 20, 20),
    elevation: 5,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.amber,
    secondary: Color.fromARGB(255, 25, 100, 96),
    shadow: Color.fromRGBO(38, 72, 165, 0.76),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 76, 147, 156),
    foregroundColor: const Color.fromARGB(255, 219, 255, 238),
  ),
);

final ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromARGB(255, 66, 65, 65),
  cardTheme: CardThemeData(
    color: const Color.fromARGB(255, 41, 64, 99),
    shadowColor: const Color.fromARGB(255, 68, 20, 20),
    elevation: 5,
  ),
  colorScheme: ColorScheme.dark(
    primary: const Color.fromARGB(255, 9, 114, 128),
    secondary: Color.fromARGB(255, 12, 41, 61),
    shadow: Color.fromRGBO(38, 72, 165, 0.76),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 20, 37, 83),
    foregroundColor: const Color.fromARGB(255, 146, 194, 233),
  ),
);
