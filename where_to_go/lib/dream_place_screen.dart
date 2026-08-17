import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen(
      {super.key, required this.name, required this.country, required this.description, required this.imagePath});
  final String name;
  final String country;
  final String description;
  final AssetGenImage imagePath;

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  var _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    // znalazłem fajny sposób na pobranie szerokości ekranu i dostosowanie wysokości obrazka w zależności od tego, czy ekran jest szeroki
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.amber[400],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red[600] : Colors.black87,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      // zapobiega błedom na dole ekranu
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: isWideScreen ? 350 : 250,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: widget.imagePath.image(fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name} ${widget.country}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.flight, size: 32),
                          SizedBox(height: 8),
                          Text("Flights", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.hotel, size: 32),
                          SizedBox(height: 8),
                          Text("Hotels", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.restaurant, size: 32),
                          SizedBox(height: 8),
                          Text("Restaurants", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
