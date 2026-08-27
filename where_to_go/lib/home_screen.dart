import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/places/places_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Where to go?"), backgroundColor: Colors.amber[400]),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: place.imagePath.image(fit: BoxFit.cover),
              ),
            ),
            title: Text(place.name),
            subtitle: Text(place.country),
            trailing: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red[600] : null,
            ),
            onTap: () async {
              await context.push("/dream_place/${place.id}");
            },
          );
        },
      ),
    );
  }
}
