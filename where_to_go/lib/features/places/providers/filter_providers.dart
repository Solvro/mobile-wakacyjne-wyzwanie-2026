import "package:riverpod_annotation/riverpod_annotation.dart";

part "filter_providers.g.dart";

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => "";

  void update(String query) {
    state = query;
  }

  void clear() {
    state = "";
  }
}
