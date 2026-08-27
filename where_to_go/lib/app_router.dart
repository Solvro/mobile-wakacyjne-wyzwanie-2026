import "package:go_router/go_router.dart";

import "dream_place_screen.dart";
import "home_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/dream_place/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
