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

