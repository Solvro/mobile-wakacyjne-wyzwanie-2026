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
  late final int placeId;

  DetailsScreen({super.key, required this.id}) : placeId = int.parse(id);

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
          final place = value.firstWhere((p) => p.id == placeId);
          final attractions = _getAttractionsForPlace();

          return Scaffold(
            appBar: AppBar(
              title: Text(place.name),
              actions: [
                IconButton(
                  icon: Icon(
                    place.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavourite ? Colors.red : null,
                  ),
                  onPressed: () async {
                    final repo = ref.read(dreamPlaceRepositoryProvider);
                    await repo.toggleFavourite(place);
                    ref.invalidate(dreamPlacesProvider);
                  },
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
                          child: Image.asset(
                            place.imagePath,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: attractions.map((attr) {
                      return Column(
                        children: [
                          Icon(attr.icon, size: 40),
                          Text(attr.label),
                        ],
                      );
                    }).toList(),
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

  List<Attraction> _getAttractionsForPlace() {
    return switch (placeId) {
      1 => const [
          Attraction(icon: Icons.wb_sunny, label: "Słońce"),
          Attraction(icon: Icons.cell_tower, label: "Tokio Tower"),
          Attraction(icon: Icons.computer, label: "Technologia"),
          Attraction(icon: Icons.train, label: "Shinkansen"),
        ],
      2 => const [
          Attraction(icon: Icons.location_city, label: "Miasto"),
          Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
          Attraction(icon: Icons.museum, label: "Muzea"),
          Attraction(icon: Icons.brush, label: "Sztuka"),
        ],
      3 => const [
          Attraction(icon: Icons.history, label: "Historia"),
          Attraction(icon: Icons.local_pizza, label: "Pizza"),
          Attraction(icon: Icons.church, label: "Bazyliki"),
          Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
        ],
      4 => const [
          Attraction(icon: Icons.location_city, label: "Miasto"),
          Attraction(icon: Icons.shopping_bag, label: "Zakupy"),
          Attraction(icon: Icons.music_note, label: "Muzyka"),
          Attraction(icon: Icons.park, label: "Central Park"),
        ],
      5 => const [
          Attraction(icon: Icons.beach_access, label: "Pustynia"),
          Attraction(icon: Icons.sailing, label: "Nil"),
          Attraction(icon: Icons.museum, label: "Muzea"),
          Attraction(icon: Icons.landscape, label: "Piramidy"),
        ],
      _ => [],
    };
  }
}
