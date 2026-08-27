import 'package:go_router/go_router.dart';
import 'package:lista_2/main.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/place/:id', 
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);