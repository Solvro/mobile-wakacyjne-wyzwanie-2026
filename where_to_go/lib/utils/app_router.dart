import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../features/auth/auth_provider.dart";
import "../models/place/place_response_dto.dart";
import "../views/bucket_list_screen.dart";
import "../views/create_dream_place_screen.dart";
import "../views/dream_place_screen_consumer_router.dart";
import "../views/login_screen.dart";
import "../views/register_screen.dart";

part "app_router.g.dart";

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    redirect: (context, state) => _handleRedirect(authState, state),
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const BucketListScreen(),
      ),
      GoRoute(
        path: "${DreamPlaceScreenConsumerRouter.route}/:id",
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return DreamPlaceScreenConsumerRouter(id: id);
        },
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.route,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
          path: CreateDreamPlaceScreen.route,
          builder: (context, state) {
            final PlaceResponseDto? existingPlace = state.extra as PlaceResponseDto?;
            return CreateDreamPlaceScreen(existingPlace: existingPlace);
          }),
    ],
  );
}

String? _handleRedirect(AsyncValue<String?> authState, GoRouterState state) {
  final isLoggingIn = state.matchedLocation == LoginScreen.route || state.matchedLocation == RegisterScreen.route;

  return authState.when(
    data: (user) {
      final isLoggedIn = user != null;

      if (!isLoggingIn && !isLoggedIn) {
        return LoginScreen.route;
      }

      if (isLoggingIn && isLoggedIn) {
        return "/";
      }

      return null;
    },
    error: (error, stack) => isLoggingIn ? null : LoginScreen.route,
    loading: () => null,
  );
}
