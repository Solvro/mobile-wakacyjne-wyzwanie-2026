import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../theme/selector.dart";
import "../auth/auth_providers.dart";
import "details_screen.dart";
import "place.dart";
import "places_provider.dart";

final showFavoritesProvider = StateProvider<bool>((ref) => false);
final searchQueryProvider = StateProvider<String>((ref) => "");

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final showOnlyFav = ref.watch(showFavoritesProvider);
    final query = ref.watch(searchQueryProvider).toLowerCase();
    final order = ref.watch(sortOrderProvider); 
    final visible = places.where((p) {
      final matchesFav = !showOnlyFav || p.isFavorite;
      final matchesQuery = query.isEmpty ||
          p.title.toLowerCase().contains(query) ||
          p.subtitle.toLowerCase().contains(query);
      return matchesFav && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Place"),
        actions: [
          IconButton(
            tooltip: "Odśwież",
            onPressed: () => ref.read(placesProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: TextField(
                onChanged: (v) =>
                    ref.read(searchQueryProvider.notifier).state = v,
                decoration: const InputDecoration(
                  hintText: "Szukaj...",
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Text("Ulubione"),
              ),
              Switch(
                value: showOnlyFav,
                onChanged: (v) =>
                    ref.read(showFavoritesProvider.notifier).state = v,
              ),
            ],
          ),

          IconButton(
            tooltip: order == SortOrder.titleAsc ? "Sortuj Z→A" : "Sortuj A→Z",
            onPressed: () => ref.read(placesProvider.notifier).toggleSortOrder(),
            icon: Icon(
              order == SortOrder.titleAsc ? Icons.sort_by_alpha : Icons.swap_vert,
            ),
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
      body: visible.isEmpty
          ? const Center(child: Text("Brak danych"))
          : ListView.separated(
              itemCount: visible.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final p = visible[i];

                return Dismissible(
                  key: ValueKey(p.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Usunąć?"),
                            content: Text('Na pewno chcesz usunąć "${p.title}"?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Anuluj"),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Usuń"),
                              ),
                            ],
                          ),
                        ) ??
                        false;
                  },
                  onDismissed: (_) {
                    ref.read(placesProvider.notifier).remove(p.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Usunięto: ${p.title}")),
                    );
                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _PlaceImage(path: p.imagePath),
                    ),
                    title: Text(p.title),
                    subtitle: Text(p.subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip:
                              p.isFavorite ? "Usuń z ulubionych" : "Dodaj do ulubionych",
                          icon: Icon(
                            p.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: p.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            ref.read(placesProvider.notifier).toggleFavorite(p.id);
                            final willBeFav = !p.isFavorite;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${p.title}: ${willBeFav ? "dodano do ulubionych" : "usunięto z ulubionych"}",
                                ),
                                duration: const Duration(milliseconds: 900),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          tooltip: "Edytuj",
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showPlaceForm(context, ref, initial: p),
                        ),
                      ],
                    ),
                    onTap: () {
                      unawaited(
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(placeId: p.id),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Dodaj miejsce",
        onPressed: () => _showPlaceForm(context, ref), 
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showPlaceForm(
  BuildContext context,
  WidgetRef ref, {
  Place? initial,
}) async {
  final titleCtrl = TextEditingController(text: initial?.title ?? "");
  final subtitleCtrl = TextEditingController(text: initial?.subtitle ?? "");
  final descCtrl = TextEditingController(text: initial?.description ?? "");
  final imageCtrl = TextEditingController(
    text: initial?.imagePath ?? "assets/images/paryz.jpg",
  );

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(initial == null ? "Nowe miejsce" : "Edytuj miejsce"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: "Tytuł"),
            ),
            TextField(
              controller: subtitleCtrl,
              decoration: const InputDecoration(labelText: "Podtytuł"),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: "Opis"),
            ),
            TextField(
              controller: imageCtrl,
              decoration:
                  const InputDecoration(labelText: "Obraz (asset lub URL)"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text("Anuluj"),
        ),
        FilledButton(
          child: Text(initial == null ? "Dodaj" : "Zapisz"),
          onPressed: () {
            final title = titleCtrl.text.trim();
            if (title.isEmpty) return;

            if (initial == null) {
              ref.read(placesProvider.notifier).add(
                    title: title,
                    subtitle: subtitleCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                    imagePath: imageCtrl.text.trim(),
                  );
            } else {
              ref.read(placesProvider.notifier).update(
                    initial.id,
                    title: title,
                    subtitle: subtitleCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                    imagePath: imageCtrl.text.trim(),
                  );
            }
            Navigator.pop(ctx);
          },
        ),
      ],
    ),
  );
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
