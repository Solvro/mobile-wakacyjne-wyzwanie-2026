import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

class Searchbar extends ConsumerWidget {
  const Searchbar({
    super.key,
    required this.searchController,
    required this.searchQuery,
  });

  final TextEditingController searchController;
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded, color: Colors.white),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded, color: Colors.white),
                onPressed: () {
                  ref.read(searchQueryProvider.notifier).state = "";
                  searchController.clear();
                },
              )
            : null,
        hintText: "Szukaj miejsc...",
        border: InputBorder.none,
        filled: false,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).state = value;
      },
    );
  }
}
