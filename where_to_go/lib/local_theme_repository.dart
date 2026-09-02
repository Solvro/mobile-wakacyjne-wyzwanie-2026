import 'package:shared_preferences/shared_preferences.dart';

class LocalThemeRepository {
  static const String _themeKey = 'is_light_theme';

  // ODCZYT: Zwraca true (jasny), false (ciemny) lub null (domyślny/systemowy)
  Future<bool?> getIsLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey);
  }

  // ZAPIS: Zapisuje wybór użytkownika w pamięci urządzenia
  Future<void> setIsLightTheme(bool? isLight) async {
    final prefs = await SharedPreferences.getInstance();

    if (isLight == null) {
      await prefs.remove(_themeKey); // Reset do motywu z urządzenia
    } else {
      await prefs.setBool(_themeKey, isLight);
    }
  }
}
