import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../theme/selector.dart";
import "../auth/auth_providers.dart";
import "create_dreamplace_screen.dart" as create;
import "details_screen.dart";
import "dreamplace_providers.dart";

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dreamPlacesControllerProvider);

    return state.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Dream Place"),
          actions: [
            IconButton(
              tooltip: "Odśwież",
              onPressed: () =>
                  ref.read(dreamPlacesControllerProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              tooltip: "Wyloguj",
              onPressed: () async {
                await ref.read(authRepositoryProvider).logout();
                if (context.mounted) context.go("/auth");
              },
              icon: const Icon(Icons.logout),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ThemeSelector(),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Błąd: $err"),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref
                    .read(dreamPlacesControllerProvider.notifier)
                    .refresh(),
                child: const Text("Spróbuj ponownie"),
              ),
            ],
          ),
        ),
      ),
      data: (places) => Scaffold(
        appBar: AppBar(
          title: const Text("Dream Place"),
          actions: [
            IconButton(
              tooltip: "Odśwież",
              onPressed: () =>
                  ref.read(dreamPlacesControllerProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              tooltip: "Wyloguj",
              onPressed: () async {
                await ref.read(authRepositoryProvider).logout();
                if (context.mounted) context.go("/auth");
              },
              icon: const Icon(Icons.logout),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ThemeSelector(),
            ),
          ],
        ),
        body: places.isEmpty
            ? const Center(
                child: Text(
                  "Brak danych",
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemCount: places.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final p = places[i];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _PlaceImage(path: p.assetPath),
                    ),
                    title: Text(p.name),
                    subtitle: Text(p.description),
                    trailing: IconButton(
                      icon: Icon(
                        p.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: p.isFavourite ? Colors.red : null,
                      ),
                      onPressed: () async {
                        final willBeFav = !p.isFavourite;
                        await ref
                            .read(dreamPlacesControllerProvider.notifier)
                            .toggleFavourite(p.id);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${p.name}: ${willBeFav ? "dodano do ulubionych" : "usunięto z ulubionych"}',
                              ),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      unawaited(context.push("${DetailsScreen.route}/${p.id}"));
                    },
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Dodaj miejsce",
          onPressed: () {
            unawaited(
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => const create.CreateDreamPlaceScreen(),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    final isUrl = path.startsWith("http://") || path.startsWith("https://");
    if (isUrl) {
      return Image.network(
        path,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.broken_image),
        ),
      );
    }
    return Image.asset(
      path,
      width: 56,
      height: 56,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const SizedBox(
        width: 56,
        height: 56,
        child: Icon(Icons.image_not_supported),
      ),
    );
  }
}
