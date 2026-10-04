import "package:go_router/go_router.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "features/auth/auth_provider.dart";
import "screens/auth_screen.dart";
import "screens/dream_place_home.dart";
import "screens/dream_place_screen.dart";
import "utils/app_animations.dart";

part "app_router.g.dart";

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggedIn = authState.value ?? false;
      final isLoggingIn = state.matchedLocation == "/login";

      if (authState.isLoading) return null;

      if (!isLoggedIn && !isLoggingIn) return "/login";
      if (isLoggedIn && isLoggingIn) return "/";

      return null;
    },
    routes: [
      GoRoute(path: "/login", builder: (context, state) => const AuthScreen()),
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
}
