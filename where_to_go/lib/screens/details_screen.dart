// ignore_for_file: migrate_design_widgets
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/places/place.dart";
import "../features/places/places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  final String placeId;

  const DetailsScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Szczegóły miejsca"),
      ),
      body: placesAsync.when(
        data: (places) {
          final Place? place = places.cast<Place?>().firstWhere(
                (p) => p?.id == placeId,
                orElse: () => null,
              );

          if (place == null) {
            return const Center(child: Text("Nie znaleziono miejsca"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (place.imageUrl != null)
                  Image.network(
                    place.imageUrl!,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 250,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 64),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              place.title,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              place.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: place.isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              unawaited(
                                ref
                                    .read(placesNotifierProvider)
                                    .toggleFavorite(place.id),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        place.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Błąd: $err")),
      ),
    );
  }
}
