import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../features/places/place_provider.dart";
import "dream_place_screen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Moje ulubione miejsca:3"),
        ),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: ref
                .watch(placesProvider)
                .map((place) => Card(
                        child: ListTile(
                      title: Text(place.title),
                      onTap: () => {GoRouter.of(context).push("${DreamPlaceScreen.route}/${place.id}")},
                    )))
                .toList()));
  }
}
