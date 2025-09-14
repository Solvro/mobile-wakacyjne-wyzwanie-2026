// lib/screens/details_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../providers/dream_places_provider.dart";
import "delete_place_dialog.dart";

class DetailsScreen extends ConsumerStatefulWidget {
  static const route = "/details";

  final int placeId;

  const DetailsScreen({super.key, required this.placeId});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final placeAsync = ref.watch(dreamPlaceProvider(widget.placeId));

    return placeAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go("/"),
          ),
          title: const Text("Szczegóły"),
        ),
        body: Center(child: Text("Błąd: $err")),
      ),
      data: (place) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go("/"),
          ),
          title: Text(place.name),
          actions: [
            Tooltip(
              message: "Usuń miejsce",
              child: Builder(
                builder: (localContext) => IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: localContext,
                      builder: (_) => DeletePlaceDialog(placeId: widget.placeId),
                    );
                    if (!mounted) return;

                    if (result ?? false) {
                      // ignore: use_build_context_synchronously
                      GoRouter.of(localContext).go("/");
                    }
                  },
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (place.filename.isNotEmpty)
                Image.network(
                  place.fullimageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const SizedBox(
                    height: 300,
                    child: Center(child: Icon(Icons.broken_image)),
                  ),
                )
              else
                const SizedBox(
                  height: 300,
                  child: Center(child: Icon(Icons.image)),
                ),
              const SizedBox(height: 20),
              Text(place.name, style: const TextStyle(fontSize: 32)),
              if (place.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    place.description,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
