import "package:go_router/go_router.dart";

import "screens/dream_place_home.dart";
import "screens/dream_place_screen.dart";
import "utils/app_animations.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const DreamPlaceHome()),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id",
      pageBuilder: (context, state) {
        final id = state.pathParameters["id"]!;
        return buildSharedAxisPage(
          state: state,
          child: DreamPlaceScreen(id: id),
        );
      },
    ),
  ],
);
