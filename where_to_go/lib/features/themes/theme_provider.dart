import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";
import "local_theme_repository.dart";

part "theme_provider.g.dart";

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final themeRepositoryProvider = Provider((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalThemeRepository(prefs);
});

@riverpod
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    return ref.read(themeRepositoryProvider).getThemeMode();
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    ref.read(themeRepositoryProvider).setThemeMode(mode);
  }
}