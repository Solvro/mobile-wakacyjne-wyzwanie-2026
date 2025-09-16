import "package:go_router/go_router.dart";
import "features/auth/ui/auth_gate.dart";
import "features/auth/ui/auth_screen.dart";

import "features/places/details_screen.dart";
import "features/places/places_screen.dart";

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: "/auth",
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const PlacesScreen(),
    ),
    GoRoute(
      path: "/details/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
