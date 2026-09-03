import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalThemeRepository {
  static const String _themeKey = 'app_theme_mode';

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if(savedTheme == 'light') return ThemeMode.light;
    if(savedTheme == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    if(mode == ThemeMode.light){
      await prefs.setString(_themeKey, 'light');
    } else if (mode == ThemeMode.dark) {
      await prefs.setString(_themeKey, 'dark');
    } else {
      await prefs.setString(_themeKey, 'system');
    }
  }
}