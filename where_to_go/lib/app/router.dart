import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../features/auth/auth_notifier.dart";
import "../features/auth/pages/login_page.dart";
import "../features/auth/pages/register_page.dart";
import "../features/places/pages/create_place_page.dart";
import "../features/places/pages/edit_place_page.dart";
import "../features/places/pages/home_page.dart";
import "../features/places/views/place_detail_view.dart";

part "router.g.dart";

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final auth = ref.watch(authNotifierProvider);
  return GoRouter(
    redirect: (context, state) {
      final loggedIn = auth.value?.isAuthed ?? false;
      final loggingIn = state.matchedLocation == LoginPage.route || state.matchedLocation == RegisterPage.route;
      if (!loggedIn && !loggingIn) {
        return LoginPage.route;
      }

      if (loggedIn && loggingIn) {
        return HomePage.route;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: HomePage.route,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: CreatePlacePage.route,
        builder: (context, state) => const CreatePlacePage(),
      ),
      GoRoute(
          path: "${EditPlacePage.route}/:id",
          builder: (context, state) {
            final id = state.pathParameters["id"]!;
            return EditPlacePage(id: int.parse(id));
          }),
      GoRoute(
        path: "${PlaceDetailView.route}/:id",
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return PlaceDetailView(id: int.parse(id));
        },
      ),
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.route,
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
