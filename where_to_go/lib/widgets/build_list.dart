import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/places/dream_place_service_provider.dart";
import "../models/place/place_response_dto.dart";
import "../utils/paths.dart";
import "../views/dream_place_screen_consumer_router.dart";

class BuildList extends ConsumerWidget {
  final PlaceResponseDto place;

  const BuildList({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await GoRouter.of(context).push("${DreamPlaceScreenConsumerRouter.route}/${place.id}");
      },
      onLongPressStart: (details) => _deletePlace(context, ref, details),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(Paths.photoPath + place.imageUrl, fit: BoxFit.cover),
                )),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(place.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
    );
  }

  Future<void> _deletePlace(BuildContext context, WidgetRef ref, LongPressStartDetails details) async {
    final pos = details.globalPosition;
    final screenSize = MediaQuery.of(context).size;

    await showMenu<void>(
        context: context,
        position: RelativeRect.fromLTRB(pos.dx, pos.dy, screenSize.width - pos.dx, screenSize.height - pos.dy),
        items: [
          PopupMenuItem(
            onTap: () async {
              await ref.read(dreamPlaceServiceProvider.notifier).deletePlace(place.id.toString());
            },
            child: const Text("Usuń"),
          )
        ]);
  }
}
