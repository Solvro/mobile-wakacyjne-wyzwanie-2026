import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "create_dream_place_screen.dart"; 
import "dream_place_screen.dart";
import "features/table/dream_place_providers.dart";
import "features/theme/local_theme_repository.dart";
import "features/theme/theme_provider.dart";

class PlaceScreenList extends ConsumerWidget {
  const PlaceScreenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);
    final placesAsync = ref.watch(dreamPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream places"),
        actions: [
          Row(
            children: [
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (isDark) async {
                  await notifier.setTheme(isDark ? AppTheme.dark : AppTheme.light);
                },
              ),
            ],
          )
        ],
      ),
      body: placesAsync.when(
        data: (places) {
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                title: Text(place.name),
                subtitle: Text(place.description),
                trailing: Icon(
                  place.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: place.isFavorite ? Colors.red : null,
                ),
                onTap: () async {
                  await context.push("${DreamPlaceScreen.route}/${place.id}");
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await context.push(CreateDreamPlaceScreen.route);
          if (created == true) {
            ref.refresh(dreamPlacesProvider);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
