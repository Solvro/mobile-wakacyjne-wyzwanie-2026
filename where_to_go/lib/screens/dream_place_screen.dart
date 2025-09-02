import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/places/place_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final int id;

  static String route = "/details";

  const DreamPlaceScreen(this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider).firstWhere((e) => e.id == id);

    return Scaffold(
      body: Column(
        children: [
          place.photo.image(fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600), place.title),
                const SizedBox(height: 8),
                Text(place.description)
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icons.beach_access, Icons.satellite, Icons.wifi, Icons.ballot]
                  .map((icon) => Column(
                        children: [Icon(icon)],
                      ))
                  .toList())
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 162, 236, 200),
      appBar: AppBar(title: Text(place.title), actions: [
        IconButton(
            onPressed: () => {ref.read(placesProvider.notifier).toggleFavorite(id)},
            icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite ? Colors.red : null))
      ]),
    );
  }
}
