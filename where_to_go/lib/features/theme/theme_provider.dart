import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_theme_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences wymaga nadpisania w main.dart');
});

final themeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepository(ref.watch(sharedPreferencesProvider));
});

class ThemeNotifier extends StateNotifier<AppThemeOption> {
  final LocalThemeRepository _repository;

  ThemeNotifier(this._repository) : super(_repository.getThemeOption());

  Future<void> setTheme(AppThemeOption option) async {
    await _repository.setThemeOption(option);
    state = option;
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppThemeOption>((ref) {
      return ThemeNotifier(ref.watch(themeRepositoryProvider));
    });
