import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/places/dream_place_service_provider.dart";
import "../themes/utils.dart";
import "../utils/error_handler.dart";
import "../utils/paths.dart";
import "create_dream_place_screen.dart";

class DreamPlaceScreenConsumerRouter extends ConsumerWidget {
  final String id;
  static String route = "/dream_place";

  const DreamPlaceScreenConsumerRouter({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(placeProvider(id));

    ref.listen(dreamPlaceServiceProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return placeAsync.when(
      data: (place) {
        return Scaffold(
            backgroundColor: context.colorScheme.primary,
            appBar: AppBar(
              backgroundColor: context.colorScheme.surface,
              title: Text(place.name),
              actions: [
                IconButton(
                  onPressed: () async {
                    await ref.read(dreamPlaceServiceProvider.notifier).toggleFavorite(id);
                  },
                  icon: place.isFavourite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                  color: place.isFavourite ? Colors.red : null,
                ),
                IconButton(
                    onPressed: () => context.push(CreateDreamPlaceScreen.route, extra: place),
                    icon: const Icon(Icons.edit)),
              ],
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(Paths.photoPath + place.imageUrl, fit: BoxFit.cover),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(place.description)
                  ],
                ),
              ),
            ])));
      },
      error: (error, stack) => const Center(child: Text("Blad")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
