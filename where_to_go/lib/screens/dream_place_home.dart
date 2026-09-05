import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/places/places_provider.dart";
import "../widgets/place_card.dart";
import "../widgets/settings_dialog.dart";

class DreamPlaceHome extends ConsumerWidget {
  const DreamPlaceHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Wymarzone destynacje",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) =>  const SettingsDialog(),
              );
            },
          ),
        ],
      ),
      body: ListView(children: [for (final place in places) PlaceCard(place: place)]),
    );
  }
}
