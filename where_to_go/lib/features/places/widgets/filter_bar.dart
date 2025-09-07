import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../providers/filter_providers.dart";
import "../service/dream_place_service.dart";

class FilterBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
          child: TextField(
        decoration: const InputDecoration(
          hintText: "Search for a place...",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        onChanged: (value) => ref.read(searchQueryProvider.notifier).update(value),
      )),
      IconButton(
          onPressed: ref.read(dreamPlaceServiceProvider.notifier).toggleFilter,
          icon: Icon(ref.read(dreamPlaceServiceProvider.notifier).isShowingOnlyFavourites
              ? Icons.favorite
              : Icons.favorite_outline)),
      IconButton(
          onPressed: ref.read(dreamPlaceServiceProvider.notifier).toggleSortOrder,
          icon: Icon(ref.read(dreamPlaceServiceProvider.notifier).isSortAsc
              ? FontAwesomeIcons.arrowDownAZ
              : FontAwesomeIcons.arrowUpAZ)),
    ]);
  }
}
