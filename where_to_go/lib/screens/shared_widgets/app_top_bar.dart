import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../places_repository.dart";
import "searchbar.dart";

final sortProvider = StateProvider<SortOrder>((ref) => SortOrder.asc);

class AppTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.sort,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final SortOrder sort;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Searchbar(searchController: searchController, searchQuery: searchQuery),
      actions: [
        IconButton(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_upward_rounded,
                  size: 24, color: sort == SortOrder.asc ? Colors.white : Colors.grey.shade400),
              Icon(Icons.arrow_downward_rounded,
                  size: 24, color: sort == SortOrder.desc ? Colors.white : Colors.grey.shade400),
              const SizedBox(width: 16),
            ],
          ),
          onPressed: () {
            if (sort == SortOrder.asc) {
              ref.read(sortProvider.notifier).state = SortOrder.desc;
            } else {
              ref.read(sortProvider.notifier).state = SortOrder.asc;
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
