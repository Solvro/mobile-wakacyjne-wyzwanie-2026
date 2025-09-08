import "package:riverpod_annotation/riverpod_annotation.dart";

import "../repositories/local_theme_repository.dart";
part "local_theme_provider.g.dart";

@riverpod
class LocalTheme extends _$LocalTheme {
  late final LocalThemeRepository _repo;

  @override
  Future<LocalThemeEnum> build() async {
    _repo = await LocalThemeRepository.create();
    return _repo.get();
  }

  void setTheme(LocalThemeEnum theme) {
    state = AsyncValue.data(theme);
  }
}
