import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "screens/dream_place_screen.dart";
import "screens/home_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id", // dynamiczny parametr
      pageBuilder: (context, state) {
        final id = state.pathParameters["id"]!;
        return CustomTransitionPage(
          key: state.pageKey,
          child: DreamPlaceScreen(id: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOut)),
              ),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
