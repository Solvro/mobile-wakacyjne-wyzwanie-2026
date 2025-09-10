import "package:flutter/material.dart";

import "../../themes/utils.dart";

class RegularAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback startSearch;
  final VoidCallback filterPlacesDialog;

  const RegularAppBar({super.key, required this.startSearch, required this.filterPlacesDialog});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.surface,
      surfaceTintColor: context.colorScheme.surfaceTint,
      title: const Text("Bucket List"),
      actions: [
        IconButton(onPressed: startSearch, icon: const Icon(Icons.search)),
        IconButton(onPressed: filterPlacesDialog, icon: const Icon(Icons.filter_list))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
