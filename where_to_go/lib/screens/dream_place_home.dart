import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/auth/auth_provider.dart";
import "../features/places/places_provider.dart";
import "../widgets/place_card.dart";
import "../widgets/settings_dialog.dart";

class DreamPlaceHome extends ConsumerWidget {
  const DreamPlaceHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wymarzone destynacje",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await showDialog<void>(context: context, builder: (context) => const SettingsDialog());
            },
          ),
        ],
      ),
      body: placesAsync.when(
        data: (places) => ListView(children: [for (final place in places) PlaceCard(place: place)]),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd ładowania: $err")),
      ),
    );
  }
}
