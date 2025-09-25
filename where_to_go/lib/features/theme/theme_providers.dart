import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "local_theme_repository.dart";

part "theme_providers.g.dart";

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
ThemeRepository themeRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value;

  if (sharedPreferences == null) {
    throw Exception("SharedPreferences not initialized");
  }
  return LocalThemeRepository(sharedPreferences);
}
