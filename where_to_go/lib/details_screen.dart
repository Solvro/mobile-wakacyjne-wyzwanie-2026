import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/database/dream_place_provider.dart";
import "features/favorite/favorite_provider.dart"; // ignore: unused_import
import "features/models/attraction.dart"; // ignore: unused_import
import "features/models/dream_place_old.dart"; // ignore: unused_import
import "features/places/places_provider.dart"; // ignore: unused_import

class DetailsScreen extends ConsumerWidget {
  static const route = "/place";
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(dreamPlacesProvider);

    return switch (placesAsync) {
      AsyncLoading() => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: const Center(child: CircularProgressIndicator()),
        ),
      AsyncError(:final error) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(child: Text("Błąd: $error")),
        ),
      AsyncData(:final value) => () {
          final place = value.firstWhere((p) => p.id == id);

          return Scaffold(
            appBar: AppBar(
              title: Text(place.name),
              actions: [
                IconButton(
                  icon: Icon(
                    place.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavourite ? Colors.red : null,
                  ),
                  onPressed: () => ref.read(dreamPlacesProvider.notifier).toggleFavourite(id),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Hero(
                        tag: place.name,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            place.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          place.description,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }(),
      _ => const SizedBox.shrink(),
    };
  }
}
