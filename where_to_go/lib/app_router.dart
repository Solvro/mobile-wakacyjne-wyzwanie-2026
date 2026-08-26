import 'package:flutter_application_1/dreamplacescreen.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${DreamPlaceScreen.route}/:id', // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
