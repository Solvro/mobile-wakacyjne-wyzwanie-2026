import 'package:flutter/material.dart';
import '../features/places/place.dart';

class DreamPlaceCard extends StatelessWidget {
  const DreamPlaceCard({
    super.key,
    required this.place,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  final Place place;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  static const Color _primaryColor = Color(0xFF1A6B8A);
  static const Color _accentColor = Color(0xFF0DD3C5);
  static const Color _cardColor = Color(0xFFE8F4F8);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  place.imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: onFavoriteToggle,
                    icon: Icon(
                      place.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: place.isFavorite ? Colors.redAccent : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoTile(Icons.sunny, place.weather),
                    _infoTile(Icons.thermostat, place.temperature),
                    _infoTile(Icons.air, place.wind),
                    _infoTile(
                      Icons.beach_access,
                      place.activities.isNotEmpty ? place.activities[0] : '-',
                    ),
                  ],
                ),
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
        Icon(icon, color: _accentColor, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
