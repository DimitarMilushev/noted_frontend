import 'package:go_router/go_router.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/shared/views/home.view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final loggedOutRoutes = [
    GoRoute(
        path: SignInView.route,
        builder: (context, state) => const SignInView(),
        ),
  ];
  final loggedInRoutes = [
    GoRoute(
      path: HomeView.route,
      builder: (context, state) => const HomeView(),
    )
  ];
  final routes = [...loggedOutRoutes, ...loggedInRoutes];

  return GoRouter(routes: routes, initialLocation: HomeView.route);
}