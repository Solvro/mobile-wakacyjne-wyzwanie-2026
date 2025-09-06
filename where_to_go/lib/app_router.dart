import "package:go_router/go_router.dart";
import "dream_place_screen.dart";
import "login_screen.dart";
import "place_screen_list.dart";
import "register_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: "/home",
      builder: (context, state) => const PlaceScreenList(),
    ),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(placeId: id);
      },
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
