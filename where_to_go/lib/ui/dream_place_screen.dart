import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/places/places_provider.dart";
import "../models/dream_place.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.placeId});

  static const route = "/places";
  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final place = ref.watch(placesProvider).firstWhere((place) => place.id == placeId);

    return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Text(place.name),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(placesProvider.notifier).toggleFavorite(placeId);
                },
                icon: Icon(
                  place.isFavorited ? Icons.favorite : Icons.favorite_border,
                ),
                color:
                    place.isFavorited ? colorScheme.error : theme.appBarTheme.foregroundColor ?? colorScheme.onSurface)
          ],
        ),
        body: Column(children: [
          Image.asset(place.imagePath, fit: BoxFit.cover),
          DreamPlaceHeader(
            name: place.name,
            description: place.description,
          ),
          DreamPlaceAttractions(
            attractions: place.attractions,
          )
        ]));
  }
}

class DreamPlaceHeader extends StatelessWidget {
  final String name;
  final String description;

  const DreamPlaceHeader({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ));
  }
}

class DreamPlaceAttractions extends StatelessWidget {
  final List<Attraction> attractions;

  const DreamPlaceAttractions({
    super.key,
    required this.attractions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(text: "Top Attractions"),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: attractions
              .map((attraction) => DreamPlaceAttractionTile(
                    attraction: attraction,
                  ))
              .toList(),
        )
      ],
    );
  }
}

class DreamPlaceAttractionTile extends StatelessWidget {
  final Attraction attraction;

  const DreamPlaceAttractionTile({
    super.key,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          attraction.icon,
          color: Theme.of(context).iconTheme.color,
        ),
        Text(
          attraction.label,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
    return Text(text, style: textStyle);
  }
}
