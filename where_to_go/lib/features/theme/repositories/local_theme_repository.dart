import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

enum LocalTheme {
  light,
  dark,
  defaultTheme;

  ThemeData? get themeData {
    return switch (this) {
      LocalTheme.dark => ThemeData.dark(),
      LocalTheme.light => ThemeData.light(),
      LocalTheme.defaultTheme => null
    };
  }
}

class LocalThemeRepository {
  static const themeKey = "theme";
  SharedPreferencesWithCache preferencesWithCache;

  LocalThemeRepository({required this.preferencesWithCache});

  static Future<LocalThemeRepository> create() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(allowList: {themeKey}));

    return LocalThemeRepository(preferencesWithCache: prefs);
  }

  LocalTheme getTheme() {
    final themeString = preferencesWithCache.getString(themeKey);

    return LocalTheme.values.firstWhere(
      (v) => v.name == themeString,
      orElse: () => LocalTheme.defaultTheme,
    );
  }

  Future<void> setTheme(LocalTheme val) async {
    await preferencesWithCache.setString(themeKey, val.name);
  }
}
