import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final String id;
  const DreamPlaceScreen({super.key, required this.id});
  static const route = "/details";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider).firstWhere((p) => p.id == id);
    final isFavorited = place.isFavorite;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text(place.title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(place.id),
            icon: isFavorited
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
                Image.asset(place.pageImagePath, height: 250, width: double.infinity, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.pageTitle,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      Text(place.description, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final feature in place.features) Column(children: [Icon(feature.icon), Text(feature.name)]),
                  ],
                ),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(place.pageImagePath, width: 400, height: double.infinity, fit: BoxFit.cover),
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
                                place.pageTitle,
                                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, height: 1.2),
                              ),
                              const SizedBox(height: 8),
                              Text(place.description, style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (final feature in place.features)
                              Column(children: [Icon(feature.icon), Text(feature.name)]),
                          ],
                        ),
                        const SizedBox(height: 16),
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
  }
}
