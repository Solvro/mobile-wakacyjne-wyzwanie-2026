import 'package:flutter/material.dart';

/// Model reprezentujący pojedyncze miejsce
class PlaceData {
  final String id;
  final String title;
  final bool isFavorite;

  const PlaceData({
    required this.id,
    required this.title,
    this.isFavorite = false,
  });

  PlaceData copyWith({bool? isFavorite}) {
    return PlaceData(
      id: id,
      title: title,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// 1. InheritedWidget przekazujący stan i metody w dół drzewa widgetów
class FavoritesInherited extends InheritedWidget {
  const FavoritesInherited({
    super.key,
    required this.places,
    required this.onToggleFavorite,
    required super.child,
  });

  final List<PlaceData> places;
  final void Function(String id) onToggleFavorite;

  // Statyczna metoda do wygodnego pobierania stanu w widgetach potomnych
  static FavoritesInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoritesInherited>();
  }

  @override
  bool updateShouldNotify(covariant FavoritesInherited oldWidget) {
    // Odśwież widoki potomne, jeśli lista miejsc uległa zmianie
    return places != oldWidget.places;
  }
}

/// 2. Widget przechowujący stan lokalny i owijający drzewo w FavoritesInherited
class FavoritesScope extends StatefulWidget {
  const FavoritesScope({super.key, required this.child});

  final Widget child;

  @override
  State<FavoritesScope> createState() => _FavoritesScopeState();
}

class _FavoritesScopeState extends State<FavoritesScope> {
  List<PlaceData> _places = const [
    PlaceData(id: '1', title: 'Santorini, Grecja'),
    PlaceData(id: '2', title: 'Jezioro Como, Włochy'),
  ];

  void _toggleFavorite(String id) {
    setState(() {
      _places = [
        for (final p in _places)
          if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesInherited(
      places: _places,
      onToggleFavorite: _toggleFavorite,
      child: widget.child,
    );
  }
}

/// 3. Przykładowy ekran potomny konsumujący stan z InheritedWidget
class InheritedWidgetExampleScreen extends StatelessWidget {
  const InheritedWidgetExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesData = FavoritesInherited.of(context);
    final places = favoritesData?.places ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget Example')),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            title: Text(place.title),
            trailing: IconButton(
              icon: Icon(
                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                favoritesData?.onToggleFavorite(place.id);
              },
            ),
          );
        },
      ),
    );
  }
}
