import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../app_router.dart";
import "../places_providers.dart";
import "shared_widgets/app_navigation_bar.dart";
import "shared_widgets/app_top_bar.dart";
import "shared_widgets/searchbar.dart";

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final favoritePlaces = ref.watch(favoritePlacesProvider(sort: sort));
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = ref.watch(searchControllerProvider);

    final Widget body = switch (favoritePlaces) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text("Error: $error")),
      AsyncData(:final value) => () {
          if (value.isEmpty) {
            return const Center(child: Text("Brak ulubionych miejsc"));
          }

          final filtered =
              value.where((place) => place.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("Nie znaleziono miejsc pasujących do wyszukiwania"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 2,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final place = filtered[index];
              final photo = ref.watch(photoProvider(place.imageUrl));

              final Widget imageWidget = photo.when(
                data: (photoBytes) => Image.memory(
                  photoBytes,
                  fit: BoxFit.cover,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => const Icon(Icons.error),
              );

              return GestureDetector(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: place.name,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            child: imageWidget,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          place.name,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await context.push("${AppRoutes.details}${place.id}");
                },
              );
            },
          );
        }(),
      _ => const Center(child: Text("Brak ulubionych miejsc"))
    };

    return Scaffold(
      appBar: AppTopBar(
        searchController: searchController,
        searchQuery: searchQuery,
        sort: sort,
      ),
      body: body,
      bottomNavigationBar: const AppNavigationBar(currentIndex: 1),
    );
  }
}
