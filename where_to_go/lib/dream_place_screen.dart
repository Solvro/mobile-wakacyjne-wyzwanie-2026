import "dart:typed_data";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/auth/tokens_provider.dart";
import "features/database/dream_place_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart";
import "places_form_view.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final int id;

  const DreamPlaceScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    // Watch the repository AsyncValue (AsyncValue<DreamPlaceRepository>)

    // Or (preferred) use the provider that already returns places:
    final dreamPlacesAsync = ref.watch(dreamPlacesProvider);
    final tokenAsync = ref.watch(tokensProvider);
    final dreamPlacesRepositoryAsync = ref.watch(dreamPlaceRepositoryProvider);
    return tokenAsync.when(
      data: (data) {
        return dreamPlacesRepositoryAsync.when(
          data: (repo) {
            return themeAsync.when(
              data: (currentTheme) {
                final themePalette = ThemePalette();
                return dreamPlacesAsync.when(
                  data: (data) {
                    // Normalize types from dynamic responses to concrete maps/lists
                    final results = (data.first as Map<String, dynamic>)["results"] as List<dynamic>;
                    final dreamPlaces = results.cast<Map<String, dynamic>>();
                    final dreamPlace = dreamPlaces.firstWhere((dp) => dp["id"] == id);
                    final isFavourited = (dreamPlace["isFavourite"] as bool?) ?? false;
                    final icon = isFavourited ? Icons.favorite : Icons.favorite_border;

                    return Scaffold(
                      backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                          color: themePalette.getSecondaryColor(currentTheme, context), // Set back button color
                        ),
                        backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
                        title: Text(dreamPlace["name"] as String,
                            style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
                        actions: [
                          IconButton(
                            icon: Icon(
                              icon,
                              color: isFavourited ? Colors.red : themePalette.getSecondaryColor(currentTheme, context),
                              size: 28,
                            ),
                            onPressed: () async {
                              try {
                                // trigger the toggle provider and await completion
                                await repo.toggleFavourite(id);
                                // ensure places are refetched / UI updated
                                ref.invalidate(dreamPlacesProvider);
                              } on Object {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Failed to toggle favourite")),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: themePalette.getPrimaryColor(currentTheme, context),
                            ),
                          ),
                        ],
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: FutureBuilder<Uint8List?>(
                              future: (() async {
                                final tokens = await ref.read(tokensProvider.future);
                                final access = tokens.$1; // nullable
                                return repo.getPhotoBytes(dreamPlace["imageUrl"] as String, access);
                              })(),
                              builder: (context, snap) {
                                if (snap.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                final bytes = snap.data;
                                if (bytes == null || bytes.isEmpty) {
                                  return Container(color: Colors.grey[200]); // placeholder
                                }
                                return Image.memory(
                                  bytes,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dreamPlace["name"] as String,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: themePalette.getSecondaryColor(currentTheme, context),
                                    )),
                                const SizedBox(height: 8),
                                Text(dreamPlace["description"] as String,
                                    style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  // Navigate to PlacesFormView in edit mode by passing the existing dreamPlace data
                                  final result = await Navigator.of(context).push<bool>(
                                    MaterialPageRoute<bool>(
                                      builder: (context) => PlacesFormView(
                                        existingPlace: dreamPlace, // Pass the current place data
                                      ),
                                    ),
                                  );

                                  // If we got back successfully, invalidate the provider to refresh the data
                                  if (result != null) {
                                    ref.invalidate(dreamPlacesProvider);
                                  }
                                } on Object catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Failed to open edit screen: $e")),
                                  );
                                }
                              },
                              icon: Icon(Icons.edit, color: themePalette.getPrimaryColor(currentTheme, context)),
                              label: Text("Edit Dream Place",
                                  style: TextStyle(color: themePalette.getPrimaryColor(currentTheme, context))),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themePalette.getSecondaryColor(currentTheme, context),
                                foregroundColor: themePalette.getPrimaryColor(currentTheme, context),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  await repo.deleteDreamPlace(dreamPlace["id"] as int);

                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                  ref.invalidate(dreamPlacesProvider);
                                } on Object {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed to delete dream place")),
                                  );
                                }
                              },
                              icon: Icon(Icons.delete, color: themePalette.getPrimaryColor(currentTheme, context)),
                              label: Text("Delete Dream Place",
                                  style: TextStyle(color: themePalette.getPrimaryColor(currentTheme, context))),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themePalette.getSecondaryColor(currentTheme, context),
                                foregroundColor: themePalette.getPrimaryColor(currentTheme, context),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => const Center(child: Text("Error loading dreamPlaces")),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const Center(child: Text("Error loading theme")),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => const Center(child: Text("Error loading repository provider")),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading tokens provider")),
    );
  }
}
