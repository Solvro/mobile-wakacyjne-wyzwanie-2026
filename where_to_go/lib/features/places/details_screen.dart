import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key, required this.placeId});
  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.read(placesProvider.notifier).byId(placeId);
    if (place == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Szczegóły")),
        body: const Center(child: Text("Nie znaleziono miejsca")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(place.id);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          _HeroImage(path: place.imagePath),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(place.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text(place.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    final isUrl = path.startsWith("http://") || path.startsWith("https://");
    final img = isUrl ? Image.network(path, fit: BoxFit.cover) : Image.asset(path, fit: BoxFit.cover);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: img,
      ),
    );
  }
}
