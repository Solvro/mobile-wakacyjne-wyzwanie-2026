import "package:riverpod_annotation/riverpod_annotation.dart";

part "favorite_provider.g.dart";

@riverpod
class Favorite extends _$Favorite {
  @override
  bool build() {
    return false; // stan początkowy
  }

  void toggle() {
    // metoda pozwaląca zmienić stan providera
    state = !state;
  }
}
