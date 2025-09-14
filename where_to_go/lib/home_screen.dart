import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "details_screen.dart";
import "features/database/dream_place_provider.dart";
import "features/filters/filtered_dream_places_provider.dart";
import "features/filters/search_query_provider.dart";
import "features/filters/show_favorites_only_provider.dart";
import "features/themes/local_theme_repository.dart";
import "features/themes/theme_notifier.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).setQuery(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final placesAsync = ref.watch(dreamPlacesProvider);
    final themeAsync = ref.watch(themeNotifierProvider);
    final filteredPlaces = ref.watch(filteredDreamPlacesProvider);
    final showFavorites = ref.watch(showFavoritesOnlyProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text("Moje wymarzone miejsca"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SearchBar(
              controller: searchController,
              hintText: "Szukaj...",
              leading: const Icon(Icons.search),
              trailing: [
                if (ref.watch(searchQueryProvider).isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      ref.read(searchQueryProvider.notifier).clear();
                    },
                  ),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              const Text("Ulubione"),
              Switch(
                value: showFavorites,
                activeTrackColor: Colors.grey[500],
                onChanged: (val) {
                  ref.read(showFavoritesOnlyProvider.notifier).setValue(value: val);
                },
              ),
            ],
          ),
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
        AsyncData() => ListView.separated(
            itemCount: filteredPlaces.length,
            separatorBuilder: (_, __) => const Divider(height: 4),
            itemBuilder: (context, index) {
              final place = filteredPlaces[index];
              return Card(
                child: ListTile(
                  horizontalTitleGap: 12,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://backend-api.w.solvro.pl/photos/${place.imageUrl}",
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
