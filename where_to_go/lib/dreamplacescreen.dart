import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'features/favorite/favorite_provider.dart';
import 'features/places/places_provider.dart';

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.id});
  static const String route = '/details';

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isFavorited = ref.watch(favoriteProvider);
    final colors = Theme.of(context).colorScheme;
    final placesAsync = ref.watch(placesProvider);
    // final place = ref.watch(placesProvider).firstWhere((p) => p.id == id);
    return placesAsync.when(
      data: (places) {
        final place = places.firstWhere((p) => p.id == id);

        return Scaffold(
          backgroundColor: colors.secondary,
          appBar: AppBar(
            title: Text(place.title),
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(placesProvider.notifier).toggleFavorite(place.id);
                },
                icon: Icon(
                  place.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: place.isFavorite ? Colors.red : null,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.primary, width: 7),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(place.path, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              place.shortdesc,
                              style: TextStyle(fontSize: 20),
                              softWrap: true,
                            ),
                            SizedBox(height: 8),
                            Text(place.description, softWrap: true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    place.listaicon[0],
                                    Text(place.listastr[0]),
                                  ],
                                ),
                                Column(
                                  children: [
                                    place.listaicon[1],
                                    Text(place.listastr[1]),
                                  ],
                                ),
                                Column(
                                  children: [
                                    place.listaicon[2],
                                    Text(place.listastr[2]),
                                  ],
                                ),
                                Column(
                                  children: [
                                    place.listaicon[3],
                                    Text(place.listastr[3]),
                                  ],
                                ),
                              ],
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
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Błąd: $e'))),
    );
  }
}
