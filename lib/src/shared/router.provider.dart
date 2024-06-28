import 'package:go_router/go_router.dart';
import 'package:noted_frontend/src/auth/presentation/views/forgotten-password.view.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-up.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/dashboard.view.dart';
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
    GoRoute(
      path: SignUpView.route,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: ForgottenPasswordView.route,
      builder: (context, state) => const ForgottenPasswordView(),
    ),
    GoRoute(
      path: HomeView.route,
      builder: (context, state) => const HomeView(),
    ),
  ];
  final loggedInRoutes = [
    GoRoute(
      path: DashboardView.route,
      builder: (context, state) => const DashboardView(),
    )
  ];
  final routes = [...loggedOutRoutes, ...loggedInRoutes];

  return GoRouter(routes: routes, initialLocation: HomeView.route);
}
