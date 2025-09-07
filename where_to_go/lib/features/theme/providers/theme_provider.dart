import "package:riverpod_annotation/riverpod_annotation.dart";

import "../repositories/local_theme_repository.dart";
part "theme_provider.g.dart";

@riverpod
class LocalThemeState extends _$LocalThemeState {
  late final LocalThemeRepository _repo;

  @override
  Future<LocalTheme> build() async {
    _repo = await LocalThemeRepository.create();
    return _repo.getTheme();
  }

  void setTheme(LocalTheme theme) {
    state = AsyncValue.data(theme);
  }
}
