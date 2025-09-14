import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../app_router.dart";
import "../places_providers.dart";

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);

    final Widget body = switch (favoritePlaces) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text("Error: $error")),
      AsyncData(:final value) => value.isEmpty
          ? Center(
              child: Text(
                "Brak ulubionych miejsc",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 2,
              ),
              itemCount: value.length,
              itemBuilder: (context, index) {
                final place = value[index];
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
            ),
      _ => const Center(child: Text("Brak ulubionych miejsc"))
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ulubione miejsca"),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Strona główna",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Ulubione",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: "Ustawienia",
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.home);
          } else if (index == 1) {
            context.go(AppRoutes.favorites);
          } else if (index == 2) {
            context.go(AppRoutes.settings);
          }
        },
      ),
    );
  }
}
