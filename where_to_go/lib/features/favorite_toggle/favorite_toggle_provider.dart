import "package:riverpod_annotation/riverpod_annotation.dart";

part "favorite_toggle_provider.g.dart";

@riverpod
class FavoriteToggleProvider extends _$FavoriteToggleProvider {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
