import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/places/places_provider.dart';
import '../features/places/place.dart';

class DreamPlaceScreen extends ConsumerWidget {
  final String id;

  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Находим место по id
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        title: Text(
          place.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFFF5E6D3),
          ),
        ),
        backgroundColor: const Color(0xFF1A1F2E),
        foregroundColor: const Color(0xFFF5E6D3),
        elevation: 8,
        shadowColor: const Color(0xFF2A2F3E),
        actions: [
          IconButton(
            onPressed: () {
              // Toggle favorite через провайдер
              ref.read(placesProvider.notifier).toggleFavorite(id);
            },
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.redAccent : const Color(0xFFF5E6D3),
            ),
            iconSize: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/westendtheatre.jpg',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF5E6D3),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  place.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFC5C9D6),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureIcon(Icons.theater_comedy, 'Teatry', const Color(0xFFE8C547)),
                _buildFeatureIcon(Icons.music_note, 'Musicale', const Color(0xFF7BB8E0)),
                _buildFeatureIcon(Icons.brightness_5, 'Światła', const Color(0xFFF5A623)),
                _buildFeatureIcon(Icons.tour, 'Zwiedzanie', const Color(0xFF6BCB9E)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '✨ Twoja wymarzona podróż do West Endu! ✨',
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color(0xFFC5C9D6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFC5C9D6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}