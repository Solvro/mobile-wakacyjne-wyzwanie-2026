import "package:riverpod_annotation/riverpod_annotation.dart";

part "search_query_provider.g.dart";

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return "";
  }

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = "";
  }
}
