// lib/features/theme/local_theme_repository.dart
import "package:shared_preferences/shared_preferences.dart";

enum ThemeChoice { system, light, dark }

class LocalThemeRepository {
  static const _key = "theme_choice";

  Future<ThemeChoice> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    switch (s) {
      case "light":
        return ThemeChoice.light;
      case "dark":
        return ThemeChoice.dark;
      default:
        return ThemeChoice.system;
    }
  }

  Future<void> save(ThemeChoice choice) async {
    final prefs = await SharedPreferences.getInstance();
    if (choice == ThemeChoice.system) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, choice == ThemeChoice.light ? "light" : "dark");
    }
  }
}
