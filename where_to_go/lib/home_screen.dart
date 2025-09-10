import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "details_screen.dart";
import "features/database/dream_place_provider.dart";
import "features/themes/local_theme_repository.dart";
import "features/themes/theme_notifier.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(dreamPlacesProvider);
    final themeAsync = ref.watch(themeNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text("Moje wymarzone miejsca"),
        actions: [
          switch (themeAsync) {
            AsyncData(value: final currentTheme) => IconButton(
                icon: Icon(currentTheme == AppTheme.light
                    ? Icons.light_mode
                    : currentTheme == AppTheme.dark
                        ? Icons.dark_mode
                        : Icons.auto_mode),
                onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
              ),
            AsyncLoading() => const CircularProgressIndicator(),
            AsyncError() => IconButton(
                icon: const Icon(Icons.error),
                onPressed: () => ref.invalidate(themeNotifierProvider),
              ),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
      body: switch (placesAsync) {
        AsyncData(value: final places) => ListView.separated(
            itemCount: places.length,
            separatorBuilder: (_, __) => const Divider(height: 4),
            itemBuilder: (context, index) {
              final place = places[index];
              return Card(
                child: ListTile(
                  horizontalTitleGap: 12,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      place.imageUrl,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    place.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: Icon(
                    place.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavourite ? Colors.red : null,
                  ),
                  onTap: () async {
                    await GoRouter.of(context).push("${DetailsScreen.route}/${place.id}");
                  },
                ),
              );
            },
          ),
        AsyncError() => Center(child: Text("Błąd: ${placesAsync.error}")),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await GoRouter.of(context).push("/create");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
