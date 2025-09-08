import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

enum LocalThemeEnum {
  light,
  dark,
  defaultTheme;

  ThemeData? get themeData {
    return switch (this) {
      LocalThemeEnum.dark => ThemeData.dark(),
      LocalThemeEnum.light => ThemeData.light(),
      LocalThemeEnum.defaultTheme => null
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

  LocalThemeEnum get() {
    final themeString = preferencesWithCache.getString(themeKey);

    return LocalThemeEnum.values.firstWhere(
      (v) => v.name == themeString,
      orElse: () => LocalThemeEnum.defaultTheme,
    );
  }

  Future<void> set(LocalThemeEnum val) async {
    await preferencesWithCache.setString(themeKey, val.name);
  }
}
