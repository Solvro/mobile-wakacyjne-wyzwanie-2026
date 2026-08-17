import "package:animations/animations.dart";
import "package:flutter/material.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple[300],
        cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      home: const DreamPlaceHome(),
    );
  }
}

// ikona + opis - zalety miejsca
class PlaceFeature {
  final IconData icon;
  final String label;

  PlaceFeature(this.icon, this.label);
}

// uniwersalne dodawanie miejsca
class Place {
  final String title;
  final String descriptionTitle;
  final String description;
  final List<PlaceFeature> features;
  final AssetGenImage image;

  const Place({
    required this.title,
    required this.descriptionTitle,
    required this.description,
    required this.features,
    required this.image,
  });
}

// animacja
class SharedRouteAnimation extends PageRouteBuilder<void> {

  SharedRouteAnimation({required Widget page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: Colors.transparent,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
      );
}

// uniwersalne dodawanie kart
class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        color: Colors.deepPurple[300],
        child: InkWell(
          onTap: () {
            Navigator.push(context, SharedRouteAnimation(page: DreamPlaceScreen(place: place)));
          },
          child: Column(
            children: [
              Hero(
                tag: place.title,
                placeholderBuilder: (context, size, child) {
                  return place.image.image(height: 200, width: double.infinity, fit: BoxFit.cover);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: place.image.image(height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  place.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[100]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HOME PAGE
class DreamPlaceHome extends StatelessWidget {
  const DreamPlaceHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          "Wymarzone destynacje",
          style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PlaceCard(
            place: Place(
              title: "🇨🇾 Pafos, Cypr",
              descriptionTitle: "Nadmorskie miasteczko na Cyprze",
              description: "Piękne widoki, malownicze plaże i urokliwe ulice",
              image: Assets.images.pafos,
              features: [
                PlaceFeature(Icons.wb_sunny, "Słońce"),
                PlaceFeature(Icons.beach_access, "Plaże"),
                PlaceFeature(Icons.restaurant, "Jedzenie"),
              ],
            ),
          ),
          PlaceCard(
            place: Place(
              title: "🇮🇹 Rzym, Włochy",
              descriptionTitle: "Antyczne miasto pełne zabytków",
              description: "Wiele znalezisk archeologicznych, centrum kultury",
              image: Assets.images.rzym,
              features: [
                PlaceFeature(Icons.local_fire_department, "Gladiatorzy"),
                PlaceFeature(Icons.dinner_dining, "Wyśmienite dania"),
                PlaceFeature(Icons.local_see, "Mnóstwo atrakcji"),
              ],
            ),
          ),
          PlaceCard(
            place: Place(
              title: "🇪🇸 Barcelona, Hiszpania",
              descriptionTitle: "Stolica katalońskiego modernizmu",
              description: "Niezwykła architektura Gaudiego, piaszczyste plaże i tętniąca życiem ulica La Rambla.",
              image: Assets.images.barcelona,
              features: [
                PlaceFeature(Icons.beach_access, "Plaża"),
                PlaceFeature(Icons.architecture, "Architektura"),
                PlaceFeature(Icons.palette, "Sztuka"),
              ],
            ),
          ),
          PlaceCard(
            place: Place(
              title: "🇲🇩 Kiszyniów, Mołdawia",
              descriptionTitle: "Najbardziej zielona stolica Europy",
              description:
                  "Spokojne miasto z licznymi parkami, brutalistyczną architekturą i słynnymi winiarniami w okolicy.",
              image: Assets.images.kiszyniow,
              features: [
                PlaceFeature(Icons.park, "Parki"),
                PlaceFeature(Icons.wine_bar, "Wino"),
                PlaceFeature(Icons.church, "Zabytki"),
              ],
            ),
          ),
          PlaceCard(
            place: Place(
              title: "🇫🇷 Nicea, Francja",
              descriptionTitle: "Perła Lazurowego Wybrzeża",
              description: "Elegancka promenada Anglików, błękitne morze i urokliwe stare miasto Vieux Nice.",
              image: Assets.images.nicea,
              features: [
                PlaceFeature(Icons.sailing, "Morze"),
                PlaceFeature(Icons.shopping_bag, "Butiki"),
                PlaceFeature(Icons.wb_sunny, "Pogoda"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// EKRAN ZE SZCZEGOLAMI
class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  var _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          widget.place.title,
          style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey[100],
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: _isFavorited
                ? Icon(Icons.star, color: Colors.grey[100])
                : Icon(Icons.star_border, color: Colors.grey[100]),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Hero(
                  tag: widget.place.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.place.image.image(fit: BoxFit.cover, height: 300),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                color: Colors.deepPurple[300],
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            widget.place.descriptionTitle,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[100]),
                          ),
                          const SizedBox(height: 8),
                          Text(widget.place.description, style: TextStyle(color: Colors.grey[100])),
                        ],
                      ),
                    ),
                    // przerwa miedzy sekcjami
                    Container(
                      height: 2,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (final feature in widget.place.features)
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(feature.icon, color: Colors.grey[100]),
                                  const SizedBox(height: 4),
                                  Text(
                                    feature.label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[100]),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
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
}
