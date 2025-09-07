import "package:shared_preferences/shared_preferences.dart";

import "../../../themes/enums/mode_theme.dart";
import "../../app/local_theme_repository.dart";

class LocalThemeRepositoryImpl implements LocalThemeRepository {
  static const _key = "app_theme";
  final SharedPreferences _sharedPreferences;

  const LocalThemeRepositoryImpl(this._sharedPreferences);

  @override
  Future<ModeTheme> getTheme() async {
    final theme = _sharedPreferences.getString(_key);
    if (theme == null) return ModeTheme.system;
    return ModeTheme.fromString(theme);
  }

  @override
  Future<void> setTheme(ModeTheme theme) async {
    await _sharedPreferences.setString(_key, theme.name);
  }
}
