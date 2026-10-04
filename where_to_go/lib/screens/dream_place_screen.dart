import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/places/place.dart";
import "../features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final String id;
  const DreamPlaceScreen({super.key, required this.id});
  static const route = "/details";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      data: (places) {
        final place = places.firstWhere((p) => p.id == int.tryParse(id));
        final isFavourited = place.isFavourite;

        return Scaffold(
          appBar: AppBar(
            title: Text(place.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              color: Colors.white,
              onPressed: () => GoRouter.of(context).pop(),
            ),
            actions: [
              IconButton(
                iconSize: 28,
                onPressed: () =>
                    ref.read(placesProvider.notifier).toggleFavourite(place),
                icon: isFavourited
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: place.fullImageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            place.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: place.fullImageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      width: 400,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text("Błąd: $err"))),
    );
  }
}
