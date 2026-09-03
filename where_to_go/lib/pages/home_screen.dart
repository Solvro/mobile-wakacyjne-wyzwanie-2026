import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/places/places_provider.dart';
import '../widgets/dream_place_card.dart';
import 'details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wymarzone miejsca'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return DreamPlaceCard(
            place: place,
            onTap: () {
              context.push('${DetailsScreen.route}/${place.id}');
            },
            onFavoriteToggle: () {
              ref.read(placesProvider.notifier).toggleFavorite(place.id);
            },
          );
        },
      ),
    );
  }
}
