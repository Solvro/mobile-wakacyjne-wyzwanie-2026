import "package:riverpod_annotation/riverpod_annotation.dart";

part "show_favorites_only_provider.g.dart";

@riverpod
class ShowFavoritesOnly extends _$ShowFavoritesOnly {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void setValue({required bool value}) {
    state = value;
  }
}
