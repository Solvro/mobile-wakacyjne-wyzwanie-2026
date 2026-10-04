import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../repositories/local_theme_repository.dart";

part "theme_provider.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  final _repository = LocalThemeRepository();

  @override
  Future<ThemeMode> build() async {
    final savedMode = await _repository.getThemeMode();
    return savedMode ?? ThemeMode.system; // odczytany motyw, jak null to system
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _repository.setThemeMode(mode);

    state = AsyncData(mode);
  }
}
