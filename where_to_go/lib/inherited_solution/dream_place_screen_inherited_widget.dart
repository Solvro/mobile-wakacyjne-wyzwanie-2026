import "package:flutter/material.dart";
import "../features/models/dream_place_old.dart";
import "favorites_provider.dart";

class DreamPlaceScreenInheritedWidget extends StatelessWidget {
  final DreamPlace place;

  const DreamPlaceScreenInheritedWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final provider = FavoritesProvider.of(context);
    final isFavorited = provider.favorites.contains(place.title);

    return Scaffold(
      backgroundColor: Colors.pink[300],
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
            onPressed: () {
              provider.toggleFavorite(place.title);
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
                  tag: place.title,
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
                    place.placeName,
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
              children: place.attractions.map((attr) {
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
  }
}
