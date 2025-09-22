import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/places/place_repository.dart";
import "../features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.placeId});

  static const route = "/places";
  final int? placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final id = placeId;
    if (id == null) {
      return const Scaffold(body: Center(child: Text("Invalid place id")));
    }
    final placeAsync = ref.watch(placeByIdProvider(id));

    return placeAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text("Error: $e"))),
      data: (place) {
        if (place == null) {
          return const Scaffold(body: Center(child: Text("Place not found")));
        }

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: Text(place.name),
            actions: [
              IconButton(
                onPressed: () async {
                  final repo = ref.read(dreamPlacesRepositoryProvider);
                  await repo.toggleFavorite(place.id, isFavorite: !place.isFavorited);
                },
                icon: Icon(place.isFavorited ? Icons.favorite : Icons.favorite_border),
                color:
                    place.isFavorited ? colorScheme.error : theme.appBarTheme.foregroundColor ?? colorScheme.onSurface,
              )
            ],
          ),
          body: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(place.imageUrl, fit: BoxFit.cover),
                ),
              ),
              DreamPlaceHeader(
                name: place.name,
                description: place.description,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DreamPlaceHeader extends StatelessWidget {
  final String name;
  final String description;

  const DreamPlaceHeader({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ));
  }
}
