// @dart=3.0
import "package:go_router/go_router.dart";
import "features/places/screens.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
