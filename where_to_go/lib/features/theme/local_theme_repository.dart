import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeOption { light, dark, system }

class LocalThemeRepository {
  static const _themeKey = 'app_theme_option';
  final SharedPreferences _prefs;

  LocalThemeRepository(this._prefs);

  AppThemeOption getThemeOption() {
    final rawValue = _prefs.getString(_themeKey);
    if (rawValue == null) return AppThemeOption.system;
    return AppThemeOption.values.firstWhere(
      (e) => e.name == rawValue,
      orElse: () => AppThemeOption.system,
    );
  }

  Future<void> setThemeOption(AppThemeOption option) async {
    await _prefs.setString(_themeKey, option.name);
  }
}
