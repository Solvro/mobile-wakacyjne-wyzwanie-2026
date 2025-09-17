import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part "local_theme_repository.g.dart";

enum AppThemeMode {
  light,
  dark,
}

abstract class ThemeRepository {
  AppThemeMode? getThemeMode();
  Future<void> setThemeMode(AppThemeMode? theme);
}

class LocalThemeRepository implements ThemeRepository {
  LocalThemeRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static const _themeKey = "app_theme";

  @override
  AppThemeMode? getThemeMode() {
    final themeString = _sharedPreferences.getString(_themeKey);

    if (themeString == AppThemeMode.light.name) {
      return AppThemeMode.light;
    } else if (themeString == AppThemeMode.dark.name) {
      return AppThemeMode.dark;
    } else {
      return null;
    }
  }

  @override
  Future<void> setThemeMode(AppThemeMode? theme) async {
    if (theme == null) {
      await _sharedPreferences.remove(_themeKey);
    } else {
      await _sharedPreferences.setString(_themeKey, theme.name);
    }
  }
}

@riverpod
Future<LocalThemeRepository> localThemeRepository(Ref ref) async {
  return LocalThemeRepository(await SharedPreferences.getInstance());
}
