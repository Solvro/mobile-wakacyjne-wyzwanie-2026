import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:where_to_go/gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wymarzone miejsca'),
        backgroundColor: Colors.pink[600],
      ),
      body: ListView(
        children: [
          PlaceCard(
              place: Place(
                  title: 'Lagonisi, Grecja',
                  homeImagePath: Assets.images.lagonisi.path,
                  pageImagePath: Assets.images.lagonisi2.path,
                  pageTitle: 'Nadmorskie miasteczko Lagonisi',
                  description: 'Nadmorska dzielnica mieszkaniowa na Riwierze Ateńskiej i południowej części Kalyvia Thorikou we wschodniej Attyce.',
                  features: [
                    Feature('Plaża piasczysta', Icons.beach_access),
                    Feature('Jedzenie', Icons.fastfood),
                    Feature('Słońce', Icons.sunny)
                  ]
              )
          ),
          PlaceCard(
              place: Place(
                  title: 'Vodice, Chorwacja',
                  homeImagePath: Assets.images.vodice.path,
                  pageImagePath: Assets.images.vodice2.path,
                  pageTitle: 'Słoneczny kurort Vodice',
                  description: 'Miasto i port w Chorwacji, w żupanii szybenicko-knińskiej, siedziba miasta Vodice.',
                  features: [
                    Feature('Plaża kamienista', Icons.beach_access),
                    Feature('Życie nocne', Icons.nightlife),
                    Feature('Słońce', Icons.sunny)
                  ]
              )
          ),
          PlaceCard(
              place: Place(
                  title: 'Rimini, Włochy',
                  homeImagePath: Assets.images.rimini2.path,
                  pageImagePath: Assets.images.rimini.path,
                  pageTitle: 'Turystyczne Rimini',
                  description: 'Jedno z najpopularniejszych miast turystyczno-wypoczynkowych nad północnym Adriatykiem.',
                  features: [
                    Feature('Plaża piasczysta', Icons.beach_access),
                    Feature('Życie nocne', Icons.nightlife),
                    Feature('Słońce', Icons.sunny),
                    Feature('Duże miasto', Icons.location_city)
                  ]
              )
          ),
          PlaceCard(
              place: Place(
                  title: 'Madryt, Hiszpania',
                  homeImagePath: Assets.images.madryt.path,
                  pageImagePath: Assets.images.madryt2.path,
                  pageTitle: 'Centrum Hiszpanii, Madryt',
                  description: 'Stolica i największe miasto Hiszpanii, położone w środkowej części kraju, nad rzeką Manzanares.',
                  features: [
                    Feature('Stolica', Icons.location_city),
                    Feature('Życie nocne', Icons.nightlife),
                    Feature('Nad rzeką', Icons.water)
                  ]
              )
          ),
          PlaceCard(
            place: Place(
              title: 'Zakopane, Polska',
              homeImagePath: Assets.images.zakopane.path,
              pageImagePath: Assets.images.zakopane2.path,
              pageTitle: 'Zimowa stolica Zakopane',
              description: 'Miasto w południowej Polsce, największa miejscowość w bezpośrednim otoczeniu Tatr, duży ośrodek sportów zimowych',
              features: [
                Feature('Góry', Icons.terrain),
                Feature('Tatrzański Park Narodowy', Icons.hiking),
                Feature('Narty', Icons.downhill_skiing)
              ]
            )
          )
        ],
      ),
    );
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

  Place({
    required this.title,
    required this.homeImagePath,
    required this.pageImagePath,
    required this.pageTitle,
    required this.description,
    required this.features,
  });
}

class PlaceCard extends StatelessWidget{
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Card(
            color: Colors.pink[600],
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            shadowColor: Colors.pink[800],
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => DreamPlaceScreen(place),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.ease);
                            return SlideTransition(position: tween.animate(curvedAnimation), child: child);
                          }
                      )
                  );
                },
                child: Column(
                    children: [
                      Image.asset(
                          place.homeImagePath,
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            place.title,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)
                        ),
                      )
                    ]
                )
            )
        )
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen(this.place, {super.key});

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
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text(widget.place.title),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
          )
        ]
      ),
      body: Column(
        children: [
          Image.asset(widget.place.pageImagePath, height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text (
                  widget.place.pageTitle,
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight(500), height: 1.2),
                ),
                SizedBox(height: 8),
                Text(widget.place.description, style: TextStyle(fontSize: 15))
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(var feature in widget.place.features)
                  Column(
                      children: [
                        Icon(feature.icon),
                        Text(feature.name)
                      ]
                  )
              ]
          ),
        ],
      ),
    );
  }
}