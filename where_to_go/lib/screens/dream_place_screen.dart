import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final String id;
  static const route = "/details";
  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider).firstWhere((p) => p.id == id);
    final isFavorited = place.isFavorite;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          place.title,
          style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey[100],
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(id),
            icon: isFavorited
                ? Icon(Icons.star_rounded, color: Colors.amber[600])
                : Icon(Icons.star_border_rounded, color: Colors.grey[100]),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Hero(
                  tag: place.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: place.image.image(fit: BoxFit.cover, height: 300),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                color: Colors.deepPurple[300],
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            place.descriptionTitle,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[100]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            place.description,
                            style: TextStyle(color: Colors.grey[100]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // przerwa miedzy sekcjami
                    Container(
                      height: 2,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (final feature in place.features)
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(feature.icon, color: Colors.grey[100]),
                                  const SizedBox(height: 4),
                                  Text(
                                    feature.label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[100]),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
