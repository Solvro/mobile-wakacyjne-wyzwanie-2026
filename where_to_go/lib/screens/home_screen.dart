import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/places/place.dart";
import "../features/places/places_provider.dart";
import "dream_place_screen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wymarzone miejsca", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[600],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return ListView(
            scrollDirection: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
            children: [for (final place in places) PlaceCard(place)],
          );
        },
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
              color: Colors.pink[600],
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: Colors.pink[800],
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => GoRouter.of(context).push("${DreamPlaceScreen.route}/${place.id}"),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(place.homeImagePath, width: double.infinity, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: SizedBox(
                            height: orientation == Orientation.portrait ? 32 : 40,
                            child: Center(
                              child: Text(
                                place.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: orientation == Orientation.portrait ? 20 : 25,
                                  color: Colors.white,
                                ),
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
                      padding: EdgeInsets.all(orientation == Orientation.portrait ? 8 : 9),
                      icon: Icon(
                        place.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: place.isFavorite ? Colors.red : Colors.white,
                        size: orientation == Orientation.portrait ? 28 : 35,
                      ),
                      onPressed: () {
                        ref.read(placesProvider.notifier).toggleFavorite(place.id);
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
