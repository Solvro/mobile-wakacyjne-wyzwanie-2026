import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:where_to_go/features/auth/auth_providers.dart";
import "package:where_to_go/features/auth/authentication_repository.dart";
import "package:where_to_go/screens/login_screen.dart";

import "../screens/dream_place_screen.dart";
import "../screens/home_screen.dart";
import "../screens/register_screen.dart";
import "../screens/settings_screen.dart";

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authStatusControllerProvider);

  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation.startsWith("/login");

      if (authStatus == AuthenticationStatus.unauthenticated) {
        return isLoggingIn ? null : '/login';
      }

      if (authStatus == AuthenticationStatus.authenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: "${DreamPlaceScreen.route}/:id",
        pageBuilder: (context, state) {
          final id = state.pathParameters["id"]!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: DreamPlaceScreen(id: id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeOut)),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: SettingsScreen.route,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.route,
        builder: (context, state) => RegisterScreen(),
      )
    ],
  );
});
