import 'package:flutter/material.dart';

class DreamPlace extends StatefulWidget {
  const DreamPlace({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.weather,
    required this.temperature,
    required this.wind,
    required this.activities,
  });

  final String title;
  final String imagePath;
  final String description;
  final String weather;
  final String temperature;
  final String wind;
  final List<String> activities;

  @override
  State<DreamPlace> createState() => _DreamPlaceState();
}

class _DreamPlaceState extends State<DreamPlace> {
  bool _isFavorite = false;

  static const Color _primaryColor = Color(0xFF1A6B8A);
  static const Color _accentColor = Color(0xFF0DD3C5);
  static const Color _cardColor = Color(0xFFE8F4F8);

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    Icons.favorite,
                    color: _isFavorite ? Colors.redAccent : Colors.white70,
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
                  widget.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: _primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
          // Info tiles
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _primaryColor.withValues(alpha: 0.3), width: 1.5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoTile(Icons.sunny, widget.weather),
                  _infoTile(Icons.thermostat, widget.temperature),
                  _infoTile(Icons.air, widget.wind),
                  _infoTile(Icons.beach_access, widget.activities[0]),
                ],
              ),
            ),
          ),
        ],
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
