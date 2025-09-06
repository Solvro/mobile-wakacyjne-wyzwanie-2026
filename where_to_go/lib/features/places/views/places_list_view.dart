import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/app_theme.dart";
import "../../common/widgets/profile_button.dart";
import "../../common/widgets/theme_selector_button.dart";
import "../pages/create_place_page.dart";
import "../service/dream_place_service.dart";
import "../utils/show_actions_menu.dart";
import "../widgets/dream_place_list_tile.dart";
import "place_detail_view.dart";

class PlacesListView extends ConsumerWidget {
  const PlacesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlacesList = ref.watch(dreamPlaceServiceProvider);

    return Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Przeglądaj piękne miejsca"),
          leading: const ProfileButton(),
          actions: [ThemeSelectorButton()],
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: ref.read(dreamPlaceServiceProvider.notifier).toggleFilter,
              icon: Icon(ref.read(dreamPlaceServiceProvider.notifier).isShowingOnlyFavourites
                  ? Icons.favorite
                  : Icons.favorite_outline)),
          dreamPlacesList.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text("Sorry, an error occured: $error"),
            data: (places) => Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPressStart: (details) async {
                    await showDeleteMenu(
                      context: context,
                      position: details.globalPosition,
                      ref: ref,
                      placeId: places[index].id,
                    );
                  },
                  onTap: () => GoRouter.of(context).push("${PlaceDetailView.route}/${places[index].id}"),
                  child: DreamPlaceListTile(dreamPlace: places[index]),
                ),
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await GoRouter.of(context).push(CreatePlacePage.route);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
