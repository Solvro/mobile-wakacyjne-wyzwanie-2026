import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class LocalThemeRepository {
  final SharedPreferences _prefs;
  static const _key = "theme_mode";

  LocalThemeRepository(this._prefs);

  ThemeMode getThemeMode() {
    final name = _prefs.getString(_key);
    return ThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_key, mode.name);
  }
}
