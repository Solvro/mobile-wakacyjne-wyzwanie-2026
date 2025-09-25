import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../db/database.dart";
import "../features/places/place_repository.dart";
import "../features/places/places_provider.dart";
import "../features/theme/app_theme.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.placeId});

  static const route = "/places";
  final int? placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = placeId;
    if (id == null) {
      return const Scaffold(body: Center(child: Text("Invalid place id")));
    }
    final placeAsync = ref.watch(placeByIdProvider(id));

    return switch (placeAsync) {
      AsyncError(:final error, :final stackTrace) => Scaffold(
          body: Center(child: Text("Error: $error\n$stackTrace")),
        ),
      AsyncValue(value: final place) when place != null => DreamPlaceView(place: place),
      _ => const Center(child: CircularProgressIndicator()),
    };
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
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: context.textTheme.bodyMedium,
            )
          ],
        ));
  }
}

class DreamPlaceView extends ConsumerWidget {
  final DreamPlace place;

  const DreamPlaceView({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(
            onPressed: () async {
              final repo = ref.read(dreamPlacesRepositoryProvider);
              await repo.toggleFavorite(place.id, isFavorite: !place.isFavorited);
            },
            icon: Icon(place.isFavorited ? Icons.favorite : Icons.favorite_border),
            color: place.isFavorited ? context.colorScheme.error : context.colorScheme.onSurface,
          )
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: SizedBox(
              width: double.infinity,
              child: Image.network(place.imageUrl, fit: BoxFit.cover),
            ),
          ),
          DreamPlaceHeader(
            name: place.name,
            description: place.description,
          ),
        ],
      ),
    );
  }
}
