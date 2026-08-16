import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class Place {
  final String name;
  final String imagePath;
  final String description;

  const Place({
    required this.name,
    required this.imagePath,
    required this.description,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlacesScreen(),
    );
  }
}

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  final List<Place> places = const [
    Place(
      name: "Białe miasteczko Oia",
      imagePath: "assets/images/Wymarzone_miej.jpg",
      description: "Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.",
    ),
    Place(
      name: "Czarne miasteczko Oia",
      imagePath: "assets/images/Wymarzone_miej.jpg",
      description: "Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.",
    ),
    Place(
      name: "Zielone miasteczko Oia",
      imagePath: "assets/images/Wymarzone_miej.jpg",
      description: "Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.",
    ),
    Place(
      name: "Czerwone miasteczko Oia",
      imagePath: "assets/images/Wymarzone_miej.jpg",
      description: "Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.",
    ),
    Place(
      name: "Żółte miasteczko Oia",
      imagePath: "assets/images/Wymarzone_miej.jpg",
      description: "Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Miejsca"),
        ),
        body: ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              leading: Image.asset(place.imagePath),
              title: Text(place.name),
              subtitle: Text(place.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DreamPlaceScreen(place: place),
                  ),
                );
              },
            );
          },
        ));
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text(widget.place.name),
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color.fromARGB(255, 36, 192, 200),
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
        body: Center(
          child: Column(children: [
            Image.asset(
              widget.place.imagePath,
              fit: BoxFit.cover,
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    widget.place.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.place.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ] //children
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: const Color.fromARGB(255, 10, 234, 43)),
                    Text("Gwiazdy"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.location_on, color: const Color.fromARGB(255, 20, 198, 32)),
                    Text("Lokacja"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.access_time, color: const Color.fromARGB(255, 50, 139, 30)),
                    Text("Czas"),
                  ],
                ),
              ],
            )
          ] //children
              ),
        ));
  }
}
