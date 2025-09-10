import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../themes/utils.dart";
import "../../utils/sort_order.dart";

class FilterDialog extends StatefulWidget {
  final SortOrder sortOrder;
  final bool showFavourite;

  const FilterDialog({super.key, required this.sortOrder, required this.showFavourite});

  @override
  State<StatefulWidget> createState() => _FilterDialogState();

  static Future<Map<String, dynamic>?> show(BuildContext context,
      {required SortOrder sortOrder, required bool showFavourite}) {
    return showDialog<Map<String, dynamic>>(
        context: context, builder: (context) => FilterDialog(sortOrder: sortOrder, showFavourite: showFavourite));
  }
}

class _FilterDialogState extends State<FilterDialog> {
  late SortOrder _tempOrder;
  late bool _tempFavourite;

  @override
  void initState() {
    super.initState();
    _tempOrder = widget.sortOrder;
    _tempFavourite = widget.showFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sortowanie i filtrowanie"),
      content: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Wyświetl miejsca alfabetycznie"),
            const SizedBox(height: 8),
            RadioGroup<SortOrder>(
              groupValue: _tempOrder,
              onChanged: (value) {
                setState(() {
                  _tempOrder = value!;
                });
              },
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Rosnąco"),
                    leading: Radio<SortOrder>(
                      value: SortOrder.ascending,
                      activeColor: context.colorScheme.onSurface,
                    ),
                    onTap: () => setState(() => _tempOrder = SortOrder.ascending),
                  ),
                  ListTile(
                    title: const Text("Malejąco"),
                    leading: Radio<SortOrder>(
                      value: SortOrder.descending,
                      activeColor: context.colorScheme.onSurface,
                    ),
                    onTap: () => setState(() => _tempOrder = SortOrder.descending),
                  ),
                ],
              ),
            ),
            const Divider(),
            CheckboxListTile(
              title: const Text("Wyświetlaj ulubione"),
              value: _tempFavourite,
              onChanged: (value) {
                setState(() {
                  _tempFavourite = value!;
                });
              },
              activeColor: context.colorScheme.onSurface,
              controlAffinity: ListTileControlAffinity.leading,
            )
          ],
        ));
      }),
      actions: [
        TextButton(
            onPressed: () => context.pop({"sortOrder": _tempOrder, "showFavourite": _tempFavourite}),
            child: const Text("Zastosuj")),
      ],
    );
  }
}
