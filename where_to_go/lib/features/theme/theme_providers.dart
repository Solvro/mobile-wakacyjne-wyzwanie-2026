import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "local_theme_repository.dart";

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value;

  if (sharedPreferences == null) {
    throw Exception("SharedPreferences not initialized");
  }
  return LocalThemeRepository(sharedPreferences);
});
