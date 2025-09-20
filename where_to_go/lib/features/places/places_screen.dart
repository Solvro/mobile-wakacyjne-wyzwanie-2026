import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../theme/selector.dart";
import "../auth/auth_providers.dart";
import "details_screen.dart";
import "places_provider.dart";

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Place"),
        actions: [
          IconButton(
            tooltip: "Odśwież",
            onPressed: () => ref.read(placesProvider.notifier).refresh(),
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
          ? const Center(child: Text("Brak danych"))
          : ListView.separated(
              itemCount: places.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final p = places[i];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: _PlaceImage(path: p.imagePath),
                  ),
                  title: Text(p.title),
                  subtitle: Text(p.subtitle),
                  trailing: IconButton(
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
                            '${p.title}: ${willBeFav ? "dodano do ulubionych" : "usunięto z ulubionych"}',
                          ),
                          duration: const Duration(milliseconds: 900),
                        ),
                      );
                    },
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
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Dodaj miejsce",
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
  final titleCtrl = TextEditingController();
  final subtitleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final imageCtrl = TextEditingController(text: "assets/images/paryz.jpg");

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Nowe miejsce"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Tytuł")),
            TextField(controller: subtitleCtrl, decoration: const InputDecoration(labelText: "Podtytuł")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Opis")),
            TextField(controller: imageCtrl, decoration: const InputDecoration(labelText: "Obraz (asset lub URL)")),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Anuluj")),
        FilledButton(
          onPressed: () {
            if (titleCtrl.text.trim().isEmpty) return;
            ref.read(placesProvider.notifier).add(
                  title: titleCtrl.text.trim(),
                  subtitle: subtitleCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                  imagePath: imageCtrl.text.trim(),
                );
            Navigator.pop(ctx);
          },
          child: const Text("Dodaj"),
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
