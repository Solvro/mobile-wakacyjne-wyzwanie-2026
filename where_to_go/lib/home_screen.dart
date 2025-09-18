import "dart:typed_data";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/auth/authentication_repository_provider.dart";
import "features/auth/tokens_provider.dart";
import "features/database/dream_place_provider.dart";
import "features/favorite_toggle/favorite_toggle_provider.dart";
import "features/searchbar/searchbar_provider.dart";
import "features/sorting/sorting_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/local_theme_repository.dart";
import "features/theme/theme.dart" show ThemePalette;

class HomeScreen extends ConsumerWidget {
  HomeScreen();

  final palette = ThemePalette();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    final dreamPlacesAsync = ref.watch(dreamPlacesProvider);

    return dreamPlacesAsync.when(
      data: (data) {
        final results = (data.first as Map<String, dynamic>)["results"] as List<dynamic>;
        final dreamPlaces = results.cast<Map<String, dynamic>>();
        return themeAsync.when(
            data: (currentTheme) {
              final icon = currentTheme == LocalTheme.light ? Icons.light_mode : Icons.dark_mode;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Scaffold(
                    key: ValueKey(currentTheme),
                    backgroundColor: palette.getPrimaryColor(currentTheme, context),
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: palette.getSecondaryColor(currentTheme, context),
                          size: 28,
                        ),
                        onPressed: () async {
                          await ref.read(authenticationRepositoryProvider).deleteTokens();
                          ref.invalidate(tokensProvider);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: palette.getPrimaryColor(currentTheme, context),
                        ),
                      ),
                      title: Text("My Fav Places",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: palette.getSecondaryColor(currentTheme, context))),
                      actions: [
                        IconButton(
                          icon: Icon(
                            icon,
                            color: palette.getSecondaryColor(currentTheme, context),
                            size: 28,
                          ),
                          onPressed: () async {
                            await ref.read(localThemeNotifierProvider.notifier).toggleTheme();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: palette.getPrimaryColor(currentTheme, context),
                          ),
                        ),
                      ],
                      backgroundColor: palette.getPrimaryColor(currentTheme, context),
                    ),
                    body: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search places...",
                            hintStyle: TextStyle(color: palette.getSecondaryColor(currentTheme, context)),
                            prefixIcon: Icon(Icons.search, color: palette.getSecondaryColor(currentTheme, context)),
                            filled: true,
                            fillColor: palette.getPrimaryColor(currentTheme, context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: palette.getSecondaryColor(currentTheme, context)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: palette.getSecondaryColor(currentTheme, context)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: palette.getSecondaryColor(currentTheme, context)),
                            ),
                          ),
                          style: TextStyle(color: palette.getSecondaryColor(currentTheme, context)),
                          onChanged: (value) {
                            ref.read(searchBarProviderProvider.notifier).updateSearchText(value);
                            final saved = ref.read(searchBarProviderProvider);
                            debugPrint("Search text updated: $saved");
                            // Implement search functionality here
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: [
                            // Add tile
                            GestureDetector(
                              onTap: () => context.push("/add"),
                              child: Card(
                                color: palette.getPrimaryColor(currentTheme, context),
                                shadowColor: palette.getSecondaryColor(currentTheme, context),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Icon(Icons.add,
                                      size: 64, color: palette.getSecondaryColor(currentTheme, context)),
                                ),
                              ),
                            ),
                            // One grid item per place, stable key per place
                            ...dreamPlaces.where((place) {
                              final favOnly = ref.watch(favoriteToggleProviderProvider);
                              final search = ref.watch(searchBarProviderProvider).trim().toLowerCase();
                              final name = (place["name"] as String? ?? "").toLowerCase();
                              final matchesSearch = search.isEmpty || name.startsWith(search);
                              final matchesFav = !favOnly || (place["isFavourite"] as bool);
                              return matchesFav && matchesSearch;
                            }).map((place) {
                              final id = place["id"] as int;
                              return GestureDetector(
                                key: ValueKey("place_$id"),
                                onTap: () => context.push("/details/$id"),
                                child: Card(
                                  color: palette.getPrimaryColor(currentTheme, context),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                          child: FutureBuilder<Uint8List?>(
                                            future: (() async {
                                              final repo = await ref.read(dreamPlaceRepositoryProvider.future);
                                              final tokens = await ref.read(tokensProvider.future);
                                              final access = tokens.$1; // nullable
                                              final imageUrl = place["imageUrl"] as String?;
                                              return repo.getPhotoBytes(imageUrl, access);
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                place["name"] as String,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: palette.getSecondaryColor(currentTheme, context),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              place["isFavourite"] as bool ? Icons.favorite : Icons.favorite_border,
                                              color: place["isFavourite"] as bool
                                                  ? Colors.red
                                                  : palette.getSecondaryColor(currentTheme, context),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                    ]),
                    // Replace the bottomNavigationBar with a bottom-aligned Container
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: palette.getPrimaryColor(currentTheme, context),
                        border: Border(
                          top: BorderSide(
                            color: palette.getSecondaryColor(currentTheme, context),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // This is crucial
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sort by name asc",
                                style: TextStyle(color: palette.getSecondaryColor(currentTheme, context)),
                              ),
                              const SizedBox(width: 10),
                              Switch(
                                value: ref.watch(sortingProviderProvider),
                                onChanged: (value) {
                                  ref.read(sortingProviderProvider.notifier).toggle();
                                  ref.invalidate(dreamPlacesProvider);
                                },
                                activeColor: palette.getPrimaryColor(currentTheme, context),
                                activeTrackColor: palette.getSecondaryColor(currentTheme, context),
                                inactiveThumbColor: palette.getSecondaryColor(currentTheme, context),
                                inactiveTrackColor: palette.getPrimaryColor(currentTheme, context),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4), // Space between switches
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Show favorites only",
                                style: TextStyle(color: palette.getSecondaryColor(currentTheme, context)),
                              ),
                              const SizedBox(width: 10),
                              Switch(
                                value: ref.watch(favoriteToggleProviderProvider),
                                onChanged: (value) {
                                  ref.read(favoriteToggleProviderProvider.notifier).toggle();
                                },
                                activeColor: palette.getPrimaryColor(currentTheme, context),
                                activeTrackColor: palette.getSecondaryColor(currentTheme, context),
                                inactiveThumbColor: palette.getSecondaryColor(currentTheme, context),
                                inactiveTrackColor: palette.getPrimaryColor(currentTheme, context),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text("Error: $err"));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading dreamPlaces")),
    );
  }
}
