import "package:flutter/material.dart";

import "../../gen/fonts.gen.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}

final _textTheme = const TextTheme().apply(fontFamily: FontFamily.plusJakartaSans);

final _cardTheme = CardThemeData(
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
);

final _lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF141414),
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF141414),
  brightness: Brightness.dark,
);

class AppTheme implements AppThemeData {
  @override
  ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _lightColorScheme,
        textTheme: _textTheme,
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: _cardTheme,
      );

  @override
  ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: _darkColorScheme,
        textTheme: _textTheme,
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: _cardTheme,
      );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
