import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/table/dream_place_providers.dart";

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/details";
  final String placeId;

  const DreamPlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(dreamPlaceProvider(placeId));

    return placeAsync.when(
      data: (place) {
        final repo = ref.read(dreamPlacesRepositoryProvider);
        final imageUrl = place.imageUrl.startsWith("http") ? place.imageUrl : repo.buildImageUrl(place.imageUrl);

        return Scaffold(
          appBar: AppBar(
            title: Text(place.name),
            actions: [
              IconButton(
                onPressed: () async {
                  await repo.updateIsFavorite(place.id, isFavorite: !place.isFavorite);
                  // ignore: unused_result
                  ref.refresh(dreamPlaceProvider(placeId));
                  // ignore: unused_result
                  ref.refresh(dreamPlacesProvider);
                },
                icon: Icon(
                  place.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: place.isFavorite ? Colors.red : null,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (imageUrl.isNotEmpty) Image.network(imageUrl),
                const SizedBox(height: 16),
                Text(place.description, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text("Error: $err"))),
    );
  }
}
