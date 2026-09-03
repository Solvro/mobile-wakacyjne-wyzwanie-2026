import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

TextTheme globalTextTheme (bool isPortrait) {
  return TextTheme(
    labelMedium: TextStyle(
      fontSize: isPortrait ? 20 : 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: const TextStyle(fontSize: 15),
    titleMedium: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, height: 1.2),
    bodyMedium: const TextStyle(fontSize: 20),
  );
}

class AppThemes {
  AppThemes._();

  static const Color _seedColor = Colors.pink;

  static ThemeData lightTheme(Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
      ),
      textTheme: globalTextTheme(isPortrait),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink[600],
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.pink[600]
      )
    );
  }

  static ThemeData darkTheme(Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          surfaceTint: Colors.black,
          surface: Colors.grey,
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: globalTextTheme(isPortrait),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white10,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
            color: Colors.white10,
        )
    );
  }
}
