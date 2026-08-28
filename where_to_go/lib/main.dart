import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wakacyjne Wyzwanie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DreamPlaceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({super.key});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        title: const Text(
          'West End Theatre, Londyn',
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
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.redAccent : const Color(0xFFF5E6D3),
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
                  'Londyński West End',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF5E6D3),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Serce londyńskiego życia teatralnego! West End to '
                  'ponad 40 teatrów z najsłynniejszymi musicalami świata. '
                  'Od "Upióra w Operze" po "Hamilton" - to marzenie '
                  'każdego miłośnika teatru.',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFFC5C9D6),
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
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: const Color(0xFFC5C9D6),
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
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFFC5C9D6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}