import "package:riverpod_annotation/riverpod_annotation.dart";

part "searchbar_provider.g.dart";

@riverpod
class SearchBarProvider extends _$SearchBarProvider {
  // Renamed class
  @override
  String build() {
    // Changed return type to String
    return ""; // Initial empty string
  }

  // Method to update search text
  void updateSearchText(String text) {
    state = text;
  }
}
