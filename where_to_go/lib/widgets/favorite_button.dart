// lib/widgets/favorite_button.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";

class FavoriteButton extends ConsumerWidget {
  final DreamPlace place;
  final double iconSize;
  final Color? backgroundColor;

  const FavoriteButton({
    super.key,
    required this.place,
    required this.iconSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: backgroundColor?.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(
          place.isFavourite ?? false ? Icons.favorite : Icons.favorite_border,
          size: iconSize,
        ),
        color: (place.isFavourite ?? false) ? Colors.red : Colors.black,
        onPressed: () async {
          final updated = place.copyWith(
            isFavourite: !(place.isFavourite ?? false),
          );
          final repo = ref.read(dreamPlaceRepositoryProvider);

          try {
            await repo.updateDreamPlace(updated);

            // ważne: odświeżamy zarówno listę, jak i pojedyncze miejsce
            ref.invalidate(dreamPlacesProvider);
            ref.invalidate(dreamPlaceProvider(place.id!));

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
      ),
    );
  }
}
