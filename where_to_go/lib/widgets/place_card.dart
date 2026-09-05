import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../models/place.dart";
import "../screens/dream_place_screen.dart";

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        //color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () async {
            await context.push("${DreamPlaceScreen.route}/${place.id}");
          },
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: place.id,
                    placeholderBuilder: (context, size, child) {
                      return place.image.image(height: 200, width: double.infinity, fit: BoxFit.cover);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: place.image.image(height: 200, width: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                  if (place.isFavorite)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, shape: BoxShape.circle),
                        child: Icon(Icons.star_rounded, color: Colors.amber[600], size: 28),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  place.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
