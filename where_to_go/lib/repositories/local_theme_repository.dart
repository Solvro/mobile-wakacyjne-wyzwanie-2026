// ignore_for_file: migrate_design_widgets
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

abstract class LocalThemeRepository {
  ThemeMode getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}

class SharedPreferencesThemeRepository implements LocalThemeRepository {
  static const _themeKey = "app_theme_mode";
  final SharedPreferences _prefs;

  SharedPreferencesThemeRepository(this._prefs);

  @override
  ThemeMode getThemeMode() {
    final savedValue = _prefs.getString(_themeKey);
    return switch (savedValue) {
      "light" => ThemeMode.light,
      "dark" => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:
        await _prefs.setString(_themeKey, "light");
      case ThemeMode.dark:
        await _prefs.setString(_themeKey, "dark");
      case ThemeMode.system:
        await _prefs.remove(_themeKey);
    }
  }
}
