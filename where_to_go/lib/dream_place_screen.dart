
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/favorite/favorite_provider.dart';
import "main.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final Place place;
  const DreamPlaceScreen(this.place, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text(place.title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => {ref.read(favoriteProvider.notifier).toggle()},
            icon: isFavorited
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                Image.asset(place.pageImagePath, height: 250, width: double.infinity, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.pageTitle,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      Text(place.description, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final feature in place.features) Column(children: [Icon(feature.icon), Text(feature.name)]),
                  ],
                ),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(place.pageImagePath, width: 400, height: double.infinity, fit: BoxFit.cover),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.pageTitle,
                                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, height: 1.2),
                              ),
                              const SizedBox(height: 8),
                              Text(place.description, style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (final feature in place.features)
                              Column(children: [Icon(feature.icon), Text(feature.name)]),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
