import "package:go_router/go_router.dart";
import "screens/details_screen.dart";
import "screens/home_screen.dart";

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/details/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"] ?? "";
        return DetailsScreen(placeId: id);
      },
    ),
  ],
);
