import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          place.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.amber[400],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red[600] : Colors.black87,
            ),
            onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(place.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: isWideScreen ? 350 : 250,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: place.imagePath.image(fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${place.name} ${place.country}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(place.description, style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5)),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.flight, size: 32),
                          SizedBox(height: 8),
                          Text("Flights", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.hotel, size: 32),
                          SizedBox(height: 8),
                          Text("Hotels", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.restaurant, size: 32),
                          SizedBox(height: 8),
                          Text("Restaurants", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
