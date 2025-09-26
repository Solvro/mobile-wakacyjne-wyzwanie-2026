import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../db/database.dart";
import "../features/places/places_provider.dart";
import "../features/theme/app_theme.dart";
import "../features/theme/local_theme_repository.dart";
import "../features/theme/theme_notifier.dart";
import "dream_place_screen.dart";

class DreamPlaceListScreen extends ConsumerWidget {
  const DreamPlaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Where2Go"),
        actions: const [
          _ThemeToggleButton(),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: switch (placesAsync) {
            AsyncError(:final error, :final stackTrace) => Center(
                child: Text("Error: $error\n$stackTrace"),
              ),
            AsyncValue(value: final places) when places != null => GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: places.map<Widget>((place) => DreamPlaceListTile(place: place)).toList(),
              ),
            _ => const Center(child: CircularProgressIndicator()),
          }),
    );
  }
}

class _ThemeToggleButton extends ConsumerWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeNotifierProvider).asData?.value ??
        (MediaQuery.platformBrightnessOf(context) == Brightness.light ? AppThemeMode.light : AppThemeMode.dark);
    final isLight = mode == AppThemeMode.light;
    final icon = isLight ? Icons.dark_mode : Icons.light_mode;

    return IconButton(
      icon: Icon(icon),
      onPressed: () async {
        final next = isLight ? AppThemeMode.dark : AppThemeMode.light;
        await ref.read(themeNotifierProvider.notifier).setThemeMode(next);
      },
    );
  }
}

class DreamPlaceListTile extends StatelessWidget {
  const DreamPlaceListTile({super.key, required this.place});

  final DreamPlace place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push("${DreamPlaceScreen.route}/${place.id}"),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(place.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Icon(
                    place.isFavorited ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: place.isFavorited ? context.colorScheme.error : context.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
