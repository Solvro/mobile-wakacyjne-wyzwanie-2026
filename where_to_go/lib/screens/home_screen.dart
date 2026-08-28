import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/places/places_provider.dart';
import '../features/places/place.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        title: const Text(
          'Moje wymarzone miejsca',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFFF5E6D3),
          ),
        ),
        backgroundColor: const Color(0xFF1A1F2E),
        foregroundColor: const Color(0xFFF5E6D3),
        elevation: 8,
        shadowColor: const Color(0xFF2A2F3E),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return _PlaceCard(place: place);
        },
      ),
    );
  }
}

class _PlaceCard extends ConsumerWidget {
  final Place place;

  const _PlaceCard({required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFF1A1F2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2A2F3E),
          child: const Icon(Icons.place, color: Color(0xFFF5E6D3)),
        ),
        title: Text(
          place.title,
          style: const TextStyle(
            color: Color(0xFFF5E6D3),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          place.description.length > 30
              ? '${place.description.substring(0, 30)}...'
              : place.description,
          style: const TextStyle(color: Color(0xFFC5C9D6)),
        ),
        trailing: Icon(
          place.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: place.isFavorite ? Colors.redAccent : const Color(0xFFC5C9D6),
        ),
        onTap: () {
          context.push('/details/${place.id}');
        },
      ),
    );
  }
}