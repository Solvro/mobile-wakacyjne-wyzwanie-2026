//lib/screens/dream_place_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/theme/local_theme_repository.dart";
import "../models/dream_place.dart";
import "../providers/auth_providers.dart";
import "../providers/dream_places_provider.dart";
import "../providers/theme_provider.dart";
import "./search_delegate.dart";
import "add_place_dialog.dart";

class DreamPlacesScreen extends ConsumerWidget {
  const DreamPlacesScreen({super.key});
  static const routeName = "/";

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Wylogować?"),
        content: const Text("Czy na pewno chcesz się wylogować?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Anuluj"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Wyloguj"),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      try {
        final authRepo = ref.read(authRepositoryProvider);
        await authRepo.logout();

        if (context.mounted) {
          GoRouter.of(context).go("/auth");
        }
      } on Exception catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Błąd wylogowania: $e")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlaces = ref.watch(dreamPlacesProvider);
    final showFavoritesOnly = ref.watch(showFavoritesOnlyProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ulubione miejsca!"),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<ThemeChoice>(
              tooltip: "Wybierz motyw",
              icon: const Icon(Icons.color_lens),
              onSelected: (choice) async {
                await ref.read(themeControllerProvider.notifier).setChoice(choice);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: ThemeChoice.system,
                  child: Text("System"),
                ),
                PopupMenuItem(
                  value: ThemeChoice.light,
                  child: Text("Jasny"),
                ),
                PopupMenuItem(
                  value: ThemeChoice.dark,
                  child: Text("Ciemny"),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: "Wyloguj",
              onPressed: () => _logout(context, ref),
            ),
          ],
        ),
        body: asyncPlaces.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Błąd: $err")),
          data: (places) {
            final filteredPlaces =
                showFavoritesOnly ? places.where((place) => place.isFavourite ?? false).toList() : places;

            return filteredPlaces.isEmpty
                ? Center(
                    child: showFavoritesOnly
                        ? const Text("Brak ulubionych miejsc")
                        : const Text("Brak miejsc — dodaj coś nowego!"),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];
                      return GestureDetector(
                        onTap: () => context.go("/details/${place.id}"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            child: Column(
                              children: [
                                Expanded(
                                  child: place.fullimageUrl.isNotEmpty
                                      ? Image.network(
                                          place.fullimageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (c, e, s) => const Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        )
                                      : const Center(child: Icon(Icons.image)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          place.name,
                                          style: const TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        place.isFavourite ?? false ? Icons.favorite : Icons.favorite_border,
                                        color: (place.isFavourite ?? false)
                                            ? Colors.red
                                            : Theme.of(context).iconTheme.color,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            size: 30,
            Icons.add,
          ),
          onPressed: () async {
            final newPlace = await showDialog<DreamPlace>(
              context: context,
              builder: (_) => const AddPlaceDialog(),
            );
            if (newPlace != null && context.mounted) {
              ref.invalidate(dreamPlacesProvider);
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            child: SizedBox(
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton dla sortowania
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.tune),
                    color: ref.watch(sortEnabledProvider) ? Colors.blue[600] : null,
                    onPressed: () {
                      final sortEnabledNotifier = ref.read(sortEnabledProvider.notifier);
                      final ascendingNotifier = ref.read(ascendingOnlyProvider.notifier);

                      if (!sortEnabledNotifier.state) {
                        // Włączamy sortowanie: domyślnie rosnąco
                        sortEnabledNotifier.state = true;
                        ascendingNotifier.state = true;
                      } else {
                        // Sortowanie włączone: toggle kierunku
                        ascendingNotifier.state = !ascendingNotifier.state;
                      }

                      ref.invalidate(dreamPlacesProvider);
                    },
                  ),

                  Row(
                    children: [
                      // IconButton dla showFavoritesOnly
                      IconButton(
                        iconSize: 30,
                        icon: Icon(
                          showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: showFavoritesOnly ? Colors.red : null,
                        onPressed: () {
                          ref.read(showFavoritesOnlyProvider.notifier).state = !showFavoritesOnly;
                        },
                      ),
                      // IconButton dla wyszukiwarki
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          final places = ref.read(dreamPlacesProvider).value ?? [];
                          await showSearch(
                            context: context,
                            delegate: SearchingDelegate(places),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
