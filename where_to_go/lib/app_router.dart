// lib/app_router.dart
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../providers/auth_providers.dart";
import "screens/auth_screen.dart";
import "screens/details_screen.dart";
import "screens/dream_place_screen.dart";
import "screens/login_screen.dart";
import "screens/register_screen.dart";

// lib/app_router.dart
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}

class RouteNames {
  static const auth = "/auth";
  static const login = "/login";
  static const register = "/register";
  static const home = "/";
  static const details = "/details";
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.read(authRepositoryProvider);

  return GoRouter(
    initialLocation: RouteNames.auth,
    redirect: (context, state) async {
      try {
        final authRepo = ref.read(authRepositoryProvider);
        final isAuthenticated = await authRepo.isLoggedIn;

        final isAuthPath = state.matchedLocation == RouteNames.auth ||
            state.matchedLocation == RouteNames.login ||
            state.matchedLocation == RouteNames.register;

        if (isAuthenticated && isAuthPath) {
          return RouteNames.home;
        }

        if (!isAuthenticated && !isAuthPath) {
          return RouteNames.auth;
        }

        return null;
      } on Exception catch (e, stackTrace) {
        // Dodaj logowanie błędu
        debugPrint("Router redirect error: $e. StackTrace: $stackTrace");
        // W przypadku błędu zawsze idź do auth
        return RouteNames.auth;
      }
    },
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges),
    routes: [
      // Auth flow
      GoRoute(
        path: RouteNames.auth,
        name: "auth",
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),

      // Main app flow (chronione)
      GoRoute(
        path: RouteNames.home,
        name: "home",
        builder: (context, state) => const DreamPlacesScreen(),
      ),
      GoRoute(
        path: "${RouteNames.details}/:id",
        name: "details",
        builder: (context, state) {
          final id = int.parse(state.pathParameters["id"]!);
          return DetailsScreen(placeId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text("Błąd 404: Strona nie znaleziona"),
      ),
    ),
  );
});
