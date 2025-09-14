import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";

class FavoriteButton extends ConsumerWidget {
  final DreamPlace place;

  const FavoriteButton({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        place.isFavourite ?? false ? Icons.favorite : Icons.favorite_border,
      ),
      color: (place.isFavourite ?? false) ? Colors.red : null,
      onPressed: () async {
        final updated = place.copyWith(
          isFavourite: !(place.isFavourite ?? false),
        );
        final repo = ref.read(dreamPlaceRepositoryProvider);

        try {
          await repo.updateDreamPlace(updated);

          // odśwież listę miejsc
          ref.invalidate(dreamPlacesProvider);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Zaktualizowano ulubione!")),
            );
          }
        } on Exception catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Błąd podczas aktualizacji: $e")),
            );
          }
        }
      },
    );
  }
}
