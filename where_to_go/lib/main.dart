import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'features/places/places_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}

//ekran główny
class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Miejsca")),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            leading: Image.asset(place.imagePath),
            title: Text(place.name),
            subtitle: Text(place.description),
            trailing: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : null,
            ),
            onTap: () {
              GoRouter.of(
                context,
              ).push("${DreamPlaceScreen.route}/${place.id}");
            },
          );
        },
      ),
    );
  }
}

// szczegóły miejsc
class DreamPlaceScreen extends ConsumerWidget {
  static const route = '/details';

  final String id;

  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(placesProvider.notifier).toggle(place.id);
            },
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(place.imagePath, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(place.description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Color.fromARGB(255, 10, 234, 43)),
                    Text("Gwiazdy"),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 20, 198, 32),
                    ),
                    Text("Lokacja"),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color.fromARGB(255, 50, 139, 30),
                    ),
                    Text("Czas"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
