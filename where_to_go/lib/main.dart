import "package:flutter/material.dart";
import "dream_place_screen.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

final places = <Place>[
  Place(
    name: "Bangkok",
    country: "Thailand",
    description: "Bangkok is the capital...",
    imagePath: Assets.images.bangkok,
  ),
  Place(
    name: "Paris",
    country: "France",
    description: "The city of light...",
    imagePath: Assets.images.paris,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 60,
                child: place.imagePath.image(fit: BoxFit.cover),
              ),
            ),
            title: Text(
              place.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(place.country),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              await Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => DreamPlaceScreen(
                    name: place.name,
                    country: place.country,
                    description: place.description,
                    imagePath: place.imagePath, // Przekazujemy konkretny obrazek
                  ),
                ),
              );
            },
          ),
        );
      },
      padding: const EdgeInsets.all(18),
    )));
  }
}

class Place {
  final String name;
  final String country;
  final String description;
  final AssetGenImage imagePath;

  // Konstruktor, który pozwala tworzyć obiekty
  Place({
    required this.name,
    required this.country,
    required this.description,
    required this.imagePath,
  });
}
