import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../data/models/create_place_dto.dart";
import "../service/dream_place_service.dart";
import "../views/create_edit_place_view.dart";
import "home_page.dart";

class CreatePlacePage extends ConsumerWidget {
  static const route = "/create_place";

  const CreatePlacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CreateEditPlaceView(
      onSubmit: (Map<String, Object?> values) async {
        final name = values["name"]! as String;
        final description = values["description"]! as String;
        final isFavourite = values["isFavourite"] != null && values["isFavourite"]! as bool;
        final file = values["image"]! as File;
        await ref.read(dreamPlaceServiceProvider.notifier).createDreamPlaceWithPhoto(
            CreatePlaceDTO(
              name: name,
              description: description,
              isFavourite: isFavourite,
            ),
            file);
        if (context.mounted) await GoRouter.of(context).push(HomePage.route);
      },
    );
  }
}
