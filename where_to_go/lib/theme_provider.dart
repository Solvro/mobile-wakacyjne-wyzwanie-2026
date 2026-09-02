import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_theme_repository.dart';

// 1. Provider udostępniający instancję repozytorium
final themeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepository();
});

// 2. Notifier zarządzający stanem motywu
class ThemeNotifier extends AsyncNotifier<bool?> {
  @override
  Future<bool?> build() async {
    final repository = ref.watch(themeRepositoryProvider);
    return await repository.getIsLightTheme();
  }

  Future<void> setTheme(bool? isLight) async {
    final repository = ref.read(themeRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.setIsLightTheme(isLight);
      return isLight;
    });
  }
}

// 3. Poprawna definicja AsyncNotifierProvider w Riverpod 2.x
final themeNotifierProvider = AsyncNotifierProvider<ThemeNotifier, bool?>(
  ThemeNotifier.new,
);