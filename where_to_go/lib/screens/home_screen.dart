// ignore_for_file: migrate_design_widgets
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../features/places/places_provider.dart";
import "../providers/theme_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesStreamProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Miejsca marzeń",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Zmień motyw",
            icon: Icon(
              switch (themeMode) {
                ThemeMode.light => Icons.light_mode,
                ThemeMode.dark => Icons.dark_mode,
                ThemeMode.system => Icons.brightness_auto,
              },
            ),
            onPressed: () {
              final nextMode = switch (themeMode) {
                ThemeMode.system => ThemeMode.light,
                ThemeMode.light => ThemeMode.dark,
                ThemeMode.dark => ThemeMode.system,
              };
              unawaited(
                ref.read(themeModeProvider.notifier).setThemeMode(nextMode),
              );
            },
          ),
        ],
      ),
      body: placesAsync.when(
        data: (places) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: place.imageUrl != null
                      ? Image.network(
                          place.imageUrl!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 56,
                            height: 56,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.place),
                          ),
                        )
                      : Container(
                          width: 56,
                          height: 56,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.place),
                        ),
                ),
                title: Text(
                  place.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  place.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        place.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: place.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        unawaited(
                          ref
                              .read(placesNotifierProvider)
                              .toggleFavorite(place.id),
                        );
                      },
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ),
                onTap: () {
                  context.go("/details/${place.id}");
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Błąd: $err")),
      ),
    );
  }
}
