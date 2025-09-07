import "dart:io";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../data/models/create_place_dto.dart";
import "../service/dream_place_service.dart";
import "../views/create_edit_place_view.dart";
import "home_page.dart";

class EditPlacePage extends ConsumerWidget {
  static const route = "/edit_place";

  final int id;
  const EditPlacePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(photoByIdProvider(id));
    return res.when(
      data: (file) {
        return CreateEditPlaceView(
          place: ref.read(placeByIdProvider(id)),
          photo: file,
          onSubmit: (Map<String, Object?> values) async {
            final name = values["name"]! as String;
            final description = values["description"]! as String;
            final isFavourite = values["isFavourite"] != null && values["isFavourite"]! as bool;
            final file = values["image"]! as File;
            await ref.read(dreamPlaceServiceProvider.notifier).updateDreamPlaceWithPhoto(
                id,
                CreatePlaceDTO(
                  name: name,
                  description: description,
                  isFavourite: isFavourite,
                ),
                file);
            if (context.mounted) await GoRouter.of(context).push(HomePage.route);
          },
        );
      },
      error: (error, stackTrace) => const Text("sorry"),
      loading: Scaffold.new,
    );
  }
}
