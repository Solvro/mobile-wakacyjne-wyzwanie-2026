import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/places/dream_place_service_provider.dart";
import "../themes/utils.dart";
import "../utils/error_handler.dart";
import "../utils/place_filter.dart";
import "../utils/sort_order.dart";
import "../widgets/appbar_widgets/filter_dialog.dart";
import "../widgets/appbar_widgets/regular_app_bar.dart";
import "../widgets/appbar_widgets/search_app_bar.dart";
import "../widgets/appbar_widgets/user_drawer.dart";
import "../widgets/build_list.dart";
import "create_dream_place_screen.dart";

class BucketListScreen extends ConsumerStatefulWidget {
  const BucketListScreen({super.key});

  @override
  ConsumerState<BucketListScreen> createState() => _BucketListScreenState();
}

class _BucketListScreenState extends ConsumerState<BucketListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isSearching = false;
  SortOrder _selectedOrder = SortOrder.ascending;
  bool _showFavourite = false;

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(dreamPlaceServiceProvider);

    ref.listen(dreamPlaceServiceProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return Scaffold(
        backgroundColor: context.colorScheme.primary,
        appBar: _isSearching
            ? SearchAppBar(
                searchController: _searchController,
                searchQuery: _searchQuery,
                onSearchChanged: _onSearchChanged,
                stopSearch: _stopSearch)
            : RegularAppBar(startSearch: _startSearch, filterPlacesDialog: () => _filterPlacesDialog(context)),
        body: placesAsync.when(
          data: (places) {
            final foundPlaces =
                PlaceFilter.findPlaces(places, searchQuery: _searchQuery, showFavourite: _showFavourite);

            return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return BuildList(place: foundPlaces[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 24);
                },
                itemCount: foundPlaces.length);
          },
          error: (error, stack) => const Center(child: Text("Brak miejsc")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => context.push(CreateDreamPlaceScreen.route),
            backgroundColor: context.colorScheme.surface,
            foregroundColor: context.colorScheme.onSurface,
            child: const Icon(Icons.add)),
        drawer: UserDrawer());
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = "";
    });

    _searchController.clear();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  Future<void> _filterPlacesDialog(BuildContext context) async {
    final filters = await FilterDialog.show(context, sortOrder: _selectedOrder, showFavourite: _showFavourite);

    if (filters != null) {
      final newOrder = filters["sortOrder"] as SortOrder;
      final newFavorite = filters["showFavourite"] as bool;

      if (newOrder != _selectedOrder) {
        await ref.read(dreamPlaceServiceProvider.notifier).sortRefresh(newOrder);
      }

      setState(() {
        _selectedOrder = newOrder;
        _showFavourite = newFavorite;
      });
    }
  }
}
