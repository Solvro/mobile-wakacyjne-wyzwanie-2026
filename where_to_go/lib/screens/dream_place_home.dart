import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/places/places_provider.dart";
import "../widgets/place_card.dart";

class DreamPlaceHome extends ConsumerWidget {
  const DreamPlaceHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          "Wymarzone destynacje",
          style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [for (final place in places) PlaceCard(place: place)]),
    );
  }
}
