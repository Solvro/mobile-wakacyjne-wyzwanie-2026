import "package:flutter/material.dart";

import "../../themes/utils.dart";
import "search_bar_field.dart";

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final void Function(String) onSearchChanged;
  final VoidCallback stopSearch;

  const SearchAppBar(
      {super.key,
      required this.searchController,
      required this.searchQuery,
      required this.onSearchChanged,
      required this.stopSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: context.colorScheme.surfaceTint,
        leading: IconButton(
          onPressed: stopSearch,
          icon: const Icon(Icons.arrow_back),
        ),
        title: SearchBarField(
            searchController: searchController, searchQuery: searchQuery, onSearchChanged: onSearchChanged));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
