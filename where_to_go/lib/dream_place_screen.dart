import "package:flutter/material.dart";
import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({super.key});

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
        title: const Text(
          "Bangkok, Thailand",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
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
                child: Assets.images.bankok.image(fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bangkok, Thailand",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Bangkok is the capital and most populous city of Thailand. It is known for its vibrant street life, cultural landmarks, and bustling markets. The city offers a mix of modern skyscrapers and historic temples, making it a popular destination for travelers seeking both adventure and cultural experiences.",
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
                      Column(children: [
                        Icon(Icons.flight, size: 32),
                        SizedBox(height: 8),
                        Text("Flights", style: TextStyle(fontSize: 16)),
                      ]),
                      Column(children: [
                        Icon(Icons.hotel, size: 32),
                        SizedBox(height: 8),
                        Text("Hotels", style: TextStyle(fontSize: 16)),
                      ]),
                      Column(children: [
                        Icon(Icons.restaurant, size: 32),
                        SizedBox(height: 8),
                        Text("Restaurants", style: TextStyle(fontSize: 16)),
                      ]),
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
