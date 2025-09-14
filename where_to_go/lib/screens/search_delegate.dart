import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../models/dream_place.dart";

class SearchingDelegate extends SearchDelegate<DreamPlace?> {
  final List<DreamPlace> places;

  SearchingDelegate(this.places);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = places.where((place) => place.name.toLowerCase().contains(query.toLowerCase())).toList();

    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text("Brak wyników"),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final place = results[index];
        return _buildPlaceTile(context, place);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? places
        : places.where((place) => place.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final place = suggestions[index];
        return _buildPlaceTile(context, place, dense: true);
      },
    );
  }

  Widget _buildPlaceTile(BuildContext context, DreamPlace place, {bool dense = false}) {
    return ListTile(
      dense: dense,
      leading: SizedBox(
        width: 50,
        height: 50,
        child: place.fullimageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  place.fullimageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 30),
                ),
              )
            : const Icon(Icons.image, size: 30),
      ),
      title: Text(place.name),
      onTap: () {
        close(context, place);
        context.go("/details/${place.id}");
      },
    );
  }
}
