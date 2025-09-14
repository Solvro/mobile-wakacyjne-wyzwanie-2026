import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "auth/auth_provider.dart";
import "auth/auth_state.dart";
import "screens/create_dream_place_screen.dart";
import "screens/details_screen.dart";
import "screens/favorites_screen.dart";
import "screens/home_screen.dart";
import "screens/login_screen.dart";
import "screens/register_screen.dart";
import "screens/settings_screen.dart";

class AppRoutes {
  static const String home = "/";
  static const String details = "/details/";
  static const String favorites = "/favorites";
  static const String login = "/login";
  static const String register = "/register";
  static const String settings = "/settings";
  static const String create = "/create";
}

GoRouter createRouter(WidgetRef ref) {
  final authListener = AuthNotifierListener(ref);

  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "${AppRoutes.details}:id",
        builder: (context, state) {
          final id = int.parse(state.pathParameters["id"]!);
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: AppRoutes.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.create,
        builder: (context, state) => CreateDreamPlaceScreen(),
      ),
    ],
    refreshListenable: authListener,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);

      final isLoggingIn = state.uri.toString() == AppRoutes.login || state.uri.toString() == AppRoutes.register;

      return authState.maybeWhen(
          authenticated: () {
            if (isLoggingIn) {
              return AppRoutes.home;
            }
            return null;
          },
          unauthenticated: () {
            if (!isLoggingIn) {
              return AppRoutes.login;
            }
            return null;
          },
          orElse: () => null);
    },
  );
}
