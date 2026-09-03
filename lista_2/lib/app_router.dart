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
        final idString = state.pathParameters['id']!;
        final id = int.parse(idString);
        
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);