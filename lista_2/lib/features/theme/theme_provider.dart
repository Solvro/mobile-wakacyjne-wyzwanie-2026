import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'local_theme_repository.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  final _repository = LocalThemeRepository();

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _repository.getTheme();
    state = savedTheme;
  }

  Future<void> changeTheme(ThemeMode newMode) async {
    await _repository.setTheme(newMode);
    state = newMode;
  }
}