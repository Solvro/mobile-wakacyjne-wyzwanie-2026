import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/database/dream_place_provider.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/place";
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(dreamPlacesProvider);

    return switch (placesAsync) {
      AsyncLoading() => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      AsyncError(:final error) => Scaffold(
          body: Center(child: Text("Błąd: $error")),
        ),
      AsyncData(:final value) => () {
          final parsedId = int.tryParse(id);

          if (parsedId == null) {
            return const Scaffold(
              body: Center(child: Text("Błędne ID miejsca.")),
            );
          }

          final matching = value.where((p) => p.id == parsedId).toList();
          if (matching.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            });

            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final place = matching.first;

          return Scaffold(
            appBar: AppBar(
              title: Text(place.name),
              actions: [
                IconButton(
                  icon: Icon(
                    place.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavourite ? Colors.red : null,
                  ),
                  onPressed: () => ref.read(dreamPlacesProvider.notifier).toggleFavourite(id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await deletePlaceWithConfirmation(context, ref, place.id!);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Wyśrodkowany obrazek
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Hero(
                          tag: place.name,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://backend-api.w.solvro.pl/photos/${place.imageUrl}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          place.description,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }(),
      _ => const SizedBox.shrink(),
    };
  }

  Future<void> deletePlaceWithConfirmation(BuildContext context, WidgetRef ref, int placeId) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Usuń miejsce"),
        content: const Text(
          "Czy na pewno chcesz usunąć to miejsce? Tej operacji nie można cofnąć.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Anuluj"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Usuń", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    if (navigator.canPop()) {
      navigator.pop();
    }

    try {
      await ref.read(dreamPlacesProvider.notifier).deletePlace(placeId.toString());
      messenger.showSnackBar(const SnackBar(content: Text("Miejsce zostało usunięte")));
    } on DioException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text("Błąd podczas usuwania: ${e.message}")));
    } on Exception catch (e) {
      messenger.showSnackBar(SnackBar(content: Text("Błąd podczas usuwania: $e")));
    }
  }
}
