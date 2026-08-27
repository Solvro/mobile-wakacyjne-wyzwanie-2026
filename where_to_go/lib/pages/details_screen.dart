import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/places/places_provider.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key, required this.id});

  final String id;
  static const String route = '/details';

  static const Color _primaryColor = Color(0xFF1A6B8A);
  static const Color _accentColor = Color(0xFF0DD3C5);
  static const Color _cardColor = Color(0xFFE8F4F8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final placeIndex = places.indexWhere((p) => p.id == id);

    if (placeIndex == -1) {
      return Scaffold(
        appBar: AppBar(title: const Text('Błąd')),
        body: const Center(child: Text('Nie znaleziono wybranego miejsca')),
      );
    }

    final place = places[placeIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(place.id);
            },
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  place.imagePath,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(placesProvider.notifier)
                            .toggleFavorite(place.id);
                      },
                      icon: Icon(
                        place.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: place.isFavorite ? Colors.redAccent : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    place.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _primaryColor.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _infoTile(Icons.sunny, place.weather),
                        _infoTile(Icons.thermostat, place.temperature),
                        _infoTile(Icons.air, place.wind),
                        _infoTile(
                          Icons.beach_access,
                          place.activities.isNotEmpty
                              ? place.activities[0]
                              : '-',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Atrakcje i aktywności:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: place.activities
                        .map(
                          (activity) => Chip(
                            label: Text(activity),
                            backgroundColor: _cardColor,
                            side: BorderSide(
                              color: _accentColor.withValues(alpha: 0.5),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: _accentColor, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
