import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../places_providers.dart";

class DetailsScreen extends ConsumerWidget {
  final int id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeDetailsProvider(id));
    //final infoColumns = ref.watch(infoColumnsProvider(id));

    return place.when(
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => Scaffold(body: Center(child: Text("Error: $error"))),
        data: (place) {
          final isFavorited = place.isFavourite;
          final placeName = place.name.split(RegExp(r",\s*")).first;
          final photo = ref.watch(photoProvider(place.imageUrl));

          final Widget imageWidget = photo.when(
            data: (photoBytes) => Image.memory(
              photoBytes,
              fit: BoxFit.cover,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const Icon(Icons.error),
          );

          return Scaffold(
            appBar: AppBar(
              title: Text(place.name),
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      key: ValueKey<bool>(isFavorited),
                      color: isFavorited ? Colors.redAccent.shade400 : null,
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(repositoryProvider).updateFavorite(place.id, isFavorite: !isFavorited);
                    invalidateProviders(ref, id);
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Hero(
                  tag: place.name,
                  child: place.imageUrl.isNotEmpty ? imageWidget : Container(height: 200, color: Colors.grey.shade300),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placeName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                        width: double.infinity,
                      ),
                      Text(place.description, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                /*infoColumns.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(child: Text("Error: $error")),
                  data: (columns) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: columns
                        .map((e) => InfoColumn(
                              icon: PlaceIcon.fromString(e.iconName).icon,
                              text: e.infoText,
                            ))
                        .toList(),
                  ),
                )*/
              ],
            ),
          );
        });
  }
}

/*class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 4,
        ),
        Text(text, style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}

enum PlaceIcon {
  restaurant("restaurant", Icons.restaurant),
  terrain("terrain", Icons.terrain),
  autoAwesome("auto_awesome", Icons.auto_awesome),
  downhillSkiing("downhill_skiing", Icons.downhill_skiing),
  landscape("landscape", Icons.landscape),
  train("train", Icons.train),
  park("park", Icons.park),
  localFlorist("local_florist", Icons.local_florist),
  ramenDining("ramen_dining", Icons.ramen_dining),
  theaters("theaters", Icons.theaters),
  beachAccess("beach_access", Icons.beach_access),
  sailing("sailing", Icons.sailing),
  water("water", Icons.water),
  wineBar("wine_bar", Icons.wine_bar),
  locationCity("location_city", Icons.location_city),
  museum("museum", Icons.museum),
  coffee("coffee", Icons.coffee),
  celebration("celebration", Icons.celebration),

  info("info", Icons.info);

  final String name;
  final IconData icon;
  const PlaceIcon(this.name, this.icon);

  static PlaceIcon fromString(String name) {
    return PlaceIcon.values.firstWhere(
      (e) => e.name == name,
      orElse: () => PlaceIcon.info,
    );
  }
}
*/
