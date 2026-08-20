import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

// dane dla jednego miejsca
class Place {
  final String title;
  final String imagePath;
  final String locationTitle;
  final String description;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String iconText1;
  final String iconText2;
  final String iconText3;

  Place({
    required this.title,
    required this.imagePath,
    required this.locationTitle,
    required this.description,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.iconText1,
    required this.iconText2,
    required this.iconText3,
  });
}

//lista miejsc
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Przykładowa lista 5 miejsc (pamiętaj o dodaniu odpowiednich zdjęć do pubspec.yaml)
  final List<Place> places = [
    Place(
      title: "Koszalin, Polska",
      imagePath: "assets/images/koszalin.jpg",
      locationTitle: "Katedra",
      description: "Katedra Niepokalanego Poczęcia Najświętszej Maryi Panny w Koszalinie.",
      icon1: Icons.location_on,
      icon2: Icons.account_balance,
      icon3: Icons.local_grocery_store,
      iconText1: "Centrum",
      iconText2: "Zabytek",
      iconText3: "Darmowe",
    ),
    Place(
      title: "Mielno, Polska",
      imagePath: "assets/images/mielno.jpg",
      locationTitle: "Plaża",
      description: "Mielno słynie z piaszcystych plaż, drogich gofrów i zimnego Bałtyku",
      icon1: Icons.beach_access,
      icon2: Icons.local_dining,
      icon3: Icons.wb_sunny,
      iconText1: "Plaża",
      iconText2: "Restauracje",
      iconText3: "Słonecznie",
    ),
    Place(
      title: "Kłodzko, Polska",
      imagePath: "assets/images/klodzko.jpg",
      locationTitle: "Most w Kłodzku",
      description: "Most w Kłodzku to zabytkowy most przekraczający rzekę.",
      icon1: Icons.location_city,
      icon2: Icons.history,
      icon3: Icons.visibility,
      iconText1: "Miasto",
      iconText2: "Historia",
      iconText3: "Widok",
    ),
    Place(
        title: "Gąski, Polska",
        imagePath: "assets/images/gaski.jpg",
        locationTitle: "Latarnia Morska",
        description: "Latarnia Morska w Gąskach to zabytkowa latarnia morska położona nad Morzem Bałtyckim.",
        icon1: Icons.landscape,
        icon2: Icons.lightbulb,
        icon3: Icons.photo_camera,
        iconText1: "Widok",
        iconText2: "Latarnia",
        iconText3: "Fotogeniczne"),
    Place(
      title: "Białogard, Polska",
      imagePath: "assets/images/bialogard.jpg",
      locationTitle: "Rynek",
      description: "Rynek w Białogardzie to centralny plac miasta, otoczony zabytkowymi kamienicami.",
      icon1: Icons.store,
      icon2: Icons.local_cafe,
      icon3: Icons.directions_walk,
      iconText1: "Sklepy",
      iconText2: "Kawiarnie",
      iconText3: "Spacer",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 145, 197, 248),
      appBar: AppBar(
        title: const Text(
          "Wymarzone Miejsca",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 170, 8, 57),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                place.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(place.locationTitle),
            subtitle: Text(place.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Przejście do ekranu szczegółowego z danymi klikniętego miejsca
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => DreamPlaceScreen(
                    title: place.title,
                    imagePath: place.imagePath,
                    locationTitle: place.locationTitle,
                    description: place.description,
                    icon1: place.icon1,
                    icon2: place.icon2,
                    icon3: place.icon3,
                    iconText1: place.iconText1,
                    iconText2: place.iconText2,
                    iconText3: place.iconText3,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  final String locationTitle;
  final String description;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String iconText1;
  final String iconText2;
  final String iconText3;

  const DreamPlaceScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.locationTitle,
    required this.description,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.iconText1,
    required this.iconText2,
    required this.iconText3,
  });

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
      backgroundColor: const Color.fromARGB(255, 49, 140, 231),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.title,
          style: const TextStyle(fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 170, 8, 57),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 172, 50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            widget.locationTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(widget.icon1, color: Colors.white),
                              const SizedBox(height: 4),
                              Text(
                                widget.iconText1,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(widget.icon2, color: Colors.white),
                              const SizedBox(height: 4),
                              Text(
                                widget.iconText2,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(widget.icon3, color: Colors.white),
                              const SizedBox(height: 4),
                              Text(
                                widget.iconText3,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
