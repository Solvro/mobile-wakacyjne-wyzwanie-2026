// ignore_for_file: migrate_design_widgets
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../repositories/local_theme_repository.dart";

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError("SharedPreferences must be overridden in main");
});

final themeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesThemeRepository(prefs);
});

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ref.watch(themeRepositoryProvider).getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(themeRepositoryProvider).saveThemeMode(mode);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
