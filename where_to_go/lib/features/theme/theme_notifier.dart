import "package:riverpod_annotation/riverpod_annotation.dart";

import "local_theme_repository.dart";

part "theme_notifier.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<AppThemeMode> build() async {
    final repository = await ref.read(localThemeRepositoryProvider.future);
    return repository.getThemeMode() ?? AppThemeMode.light;
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    final repository = await ref.read(localThemeRepositoryProvider.future);
    await repository.setThemeMode(mode);
    state = AsyncValue.data(mode);
  }

  Future<void> clearTheme() async {
    final repository = await ref.read(localThemeRepositoryProvider.future);
    await repository.setThemeMode(null);
    state = const AsyncValue.data(AppThemeMode.light);
  }
}
