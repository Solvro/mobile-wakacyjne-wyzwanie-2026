import "package:go_router/go_router.dart";

import "screens/dream_place_screen.dart";
import "screens/home_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id", // dynamiczny parametr
      builder: (context, state) {
        final id = int.parse(state.pathParameters["id"] ?? "");
        return DreamPlaceScreen(id);
      },
    ),
  ],
);
