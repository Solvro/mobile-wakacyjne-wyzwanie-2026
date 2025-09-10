import "package:flutter/material.dart";

class SearchBarField extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final void Function(String) onSearchChanged;

  const SearchBarField(
      {super.key, required this.searchController, required this.searchQuery, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
          hintText: "Wyszukaj miejsce",
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged("");
                  },
                  icon: const Icon(Icons.clear))
              : null,
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
