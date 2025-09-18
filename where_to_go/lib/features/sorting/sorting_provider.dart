import "package:riverpod_annotation/riverpod_annotation.dart";

part "sorting_provider.g.dart";

@riverpod
class SortingProvider extends _$SortingProvider {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
