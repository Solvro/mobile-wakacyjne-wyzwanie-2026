import "package:flutter/material.dart";

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[100],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple[300],
        foregroundColor: Colors.grey[100],
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: Colors.deepPurple[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.deepPurple[300]!,
        onPrimary: Colors.grey[100]!,
        secondaryContainer: Colors.deepPurple[100],
        onSecondaryContainer: Colors.deepPurple[900],
        surface: Colors.grey[100]!,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850], foregroundColor: Colors.grey[100], centerTitle: true),
      cardTheme: CardThemeData(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.grey[500],
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.deepPurple[200]!,
        onPrimary: Colors.grey[100]!,
        secondaryContainer: Colors.deepPurple[800],
        onSecondaryContainer: Colors.grey[100],
        surface: Colors.grey[900]!,
      ),
    );
  }
}
