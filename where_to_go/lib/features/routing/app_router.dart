import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../../auth_screen.dart";
import "../../create_dream_place_screen.dart";
import "../../details_screen.dart";
import "../../home_screen.dart";
import "../auth/auth_provider.dart";

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/auth",
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: "/create",
        builder: (context, state) => const CreateDreamPlaceScreen(),
      ),
      GoRoute(
        path: "${DetailsScreen.route}/:id",
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return DetailsScreen(id: id);
        },
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isLoggedIn = authState.value ?? false;
      final goingToAuth = state.uri.toString().startsWith("/auth");

      if (!isLoggedIn && !goingToAuth) return "/auth";
      if (isLoggedIn && goingToAuth) return "/";
      return null;
    },
    refreshListenable: _AuthNotifierListener(ref),
  );
});

class _AuthNotifierListener extends ChangeNotifier {
  _AuthNotifierListener(Ref ref) {
    ref.listen<AsyncValue<bool>>(authNotifierProvider, (_, __) {
      notifyListeners();
    });
  }
}
