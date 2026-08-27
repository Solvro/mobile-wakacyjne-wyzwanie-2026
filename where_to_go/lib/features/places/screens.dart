import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "places_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

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
            trailing: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : Colors.grey,
            ),
            onTap: () {
              unawaited(
                GoRouter.of(context).push(
                  "${DreamPlaceScreen.route}/${place.id}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/details";
  final String id;

  const DreamPlaceScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((place) => place.id == id);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 140, 231),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          place.title,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 170, 8, 57),
        actions: [
          IconButton(
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              ref.read(placesProvider.notifier).toggle(id);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 300,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 172, 50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        place.imagePath,
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.locationTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place.description,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _PlaceInfo(icon: place.icon1, text: place.iconText1),
                          _PlaceInfo(icon: place.icon2, text: place.iconText2),
                          _PlaceInfo(icon: place.icon3, text: place.iconText3),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PlaceInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
