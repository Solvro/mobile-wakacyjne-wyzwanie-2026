import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../app_router.dart";

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Strona główna",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: "Ulubione",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: "Ustawienia",
        ),
      ],
      selectedItemColor: Theme.of(context).colorScheme.primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          context.go(AppRoutes.home);
        } else if (index == 1) {
          context.go(AppRoutes.favorites);
        } else if (index == 2) {
          context.go(AppRoutes.settings);
        }
      },
    );
  }
}
