import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/places/place.dart";
import "../features/places/places_provider.dart";
import "dream_place_screen.dart";
import "settings_screen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wymarzone miejsca"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.settings, size: 28),
              onPressed: () => GoRouter.of(context).push(SettingsScreen.route),
            ),
          ),
        ],
      ),
      body: placesAsync.when(
        data: (places) => OrientationBuilder(
          builder: (context, orientation) {
            return ListView(
              scrollDirection: orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [for (final place in places) PlaceCard(place)],
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd bazy: $err")),
      ),
    );
  }
}

class PlaceCard extends ConsumerWidget {
  final Place place;

  const PlaceCard(this.place, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: orientation == Orientation.portrait ? 0 : 8,
            left: 8,
            right: orientation == Orientation.portrait ? 8 : 0,
            top: 8,
          ),
          child: SizedBox(
            width: 400,
            height: 229,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () =>
                        GoRouter.of(context)
                            .push("${DreamPlaceScreen.route}/${place.id}"),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            place.homeImagePath,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: SizedBox(
                            height: orientation == Orientation.portrait
                                ? 32
                                : 40,
                            child: Center(
                              child: Text(
                                place.title,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      padding: EdgeInsets.all(
                        orientation == Orientation.portrait ? 8 : 9,
                      ),
                      icon: Icon(
                        place.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: place.isFavorite ? Colors.red : Colors.white,
                        size: orientation == Orientation.portrait ? 28 : 35,
                      ),
                      onPressed: () {
                        ref
                            .read(placesProvider.notifier)
                            .toggleFavorite(place.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
