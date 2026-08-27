import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/favorite/favorite_provider.dart";
import "dream_place_screen.dart";

import "gen/assets.gen.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class Feature {
  final String name;
  final IconData icon;

  Feature(this.name, this.icon);
}

class Place {
  final String title;
  final String homeImagePath;
  final String pageImagePath;
  final String pageTitle;
  final String description;
  final List<Feature> features;
  final bool isFavorite;

  const Place({
    required this.title,
    required this.homeImagePath,
    required this.pageImagePath,
    required this.pageTitle,
    required this.description,
    required this.features,
    this.isFavorite = false
  });
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wymarzone miejsca", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[600],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return ListView(
            scrollDirection: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
            children: [
              PlaceCard(
                place: Place(
                  title: "Lagonisi, Grecja",
                  homeImagePath: Assets.images.lagonisi.path,
                  pageImagePath: Assets.images.lagonisi2.path,
                  pageTitle: "Nadmorskie miasteczko Lagonisi",
                  description: "Nadmorska dzielnica mieszkaniowa na Riwierze Ateńskiej i południowej części Kalyvia Thorikou we wschodniej Attyce.",
                  features: [
                    Feature("Plaża piasczysta", Icons.beach_access),
                    Feature("Jedzenie", Icons.fastfood),
                    Feature("Słońce", Icons.sunny),
                  ],
                ),
              ),
              PlaceCard(
                place: Place(
                  title: "Vodice, Chorwacja",
                  homeImagePath: Assets.images.vodice.path,
                  pageImagePath: Assets.images.vodice2.path,
                  pageTitle: "Słoneczny kurort Vodice",
                  description: "Miasto i port w Chorwacji, w żupanii szybenicko-knińskiej, siedziba miasta Vodice.",
                  features: [
                    Feature("Plaża kamienista", Icons.beach_access),
                    Feature("Życie nocne", Icons.nightlife),
                    Feature("Słońce", Icons.sunny),
                  ],
                ),
              ),
              PlaceCard(
                place: Place(
                  title: "Rimini, Włochy",
                  homeImagePath: Assets.images.rimini2.path,
                  pageImagePath: Assets.images.rimini.path,
                  pageTitle: "Turystyczne Rimini",
                  description:
                      "Jedno z najpopularniejszych miast turystyczno-wypoczynkowych nad północnym Adriatykiem.",
                  features: [
                    Feature("Plaża piasczysta", Icons.beach_access),
                    Feature("Życie nocne", Icons.nightlife),
                    Feature("Słońce", Icons.sunny),
                    Feature("Duże miasto", Icons.location_city),
                  ],
                ),
              ),
              PlaceCard(
                place: Place(
                  title: "Madryt, Hiszpania",
                  homeImagePath: Assets.images.madryt.path,
                  pageImagePath: Assets.images.madryt2.path,
                  pageTitle: "Centrum Hiszpanii, Madryt",
                  description:
                      "Stolica i największe miasto Hiszpanii, położone w środkowej części kraju, nad rzeką Manzanares.",
                  features: [
                    Feature("Stolica", Icons.location_city),
                    Feature("Życie nocne", Icons.nightlife),
                    Feature("Nad rzeką", Icons.water),
                  ],
                ),
              ),
              PlaceCard(
                place: Place(
                  title: "Zakopane, Polska",
                  homeImagePath: Assets.images.zakopane.path,
                  pageImagePath: Assets.images.zakopane2.path,
                  pageTitle: "Zimowa stolica, Zakopane",
                  description: "Miasto w południowej Polsce, największa miejscowość w bezpośrednim otoczeniu Tatr, duży ośrodek sportów zimowych",
                  features: [
                    Feature("Góry", Icons.terrain),
                    Feature("Park Narodowy", Icons.hiking),
                    Feature("Narty", Icons.downhill_skiing),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: orientation == Orientation.portrait ? 0 : 8,
            left: 8,
            right: orientation == Orientation.portrait ? 8 : 0,
            top: 8,
          ),
          child: SizedBox(
            width: 400,
            height: 229,
            child: Card(
              color: Colors.pink[600],
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: Colors.pink[800],
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder<dynamic>(
                      pageBuilder: (context, animation, secondaryAnimation) => DreamPlaceScreen(place),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
                        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.ease);
                        return SlideTransition(position: tween.animate(curvedAnimation), child: child);
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(place.homeImagePath, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: SizedBox(
                        height: orientation == Orientation.portrait ? 32 : 40,
                        child: Center(
                          child: Text(
                            place.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: orientation == Orientation.portrait ? 20 : 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

