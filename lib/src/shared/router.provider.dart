import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_frontend/src/auth/presentation/views/forgotten-password.view.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-up.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/deleted.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/note.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/notebook.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/side-menu-nav.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/starred.view.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';
import 'package:noted_frontend/src/shared/views/home.view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "rootNavigator");
  final shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "shellNavigator");

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
      parentNavigatorKey: rootNavigatorKey,
      path: HomeView.route,
      builder: (context, state) => const HomeView(),
    ),
  ];
  final loggedInRoutes = [
    GoRoute(
        parentNavigatorKey: shellNavigatorKey,
        path: DashboardView.route,
        builder: (context, state) => const DashboardView(),
        routes: [
          GoRoute(
              path: NoteView.route.substring(1),
              builder: (context, state) {
                final num id = num.parse(state.pathParameters['noteId']!);
                return NoteView(id);
              })
        ]),
    GoRoute(
        path: NotebookView.route,
        builder: (context, state) {
          final int id = int.parse(state.pathParameters['notebookId']!);
          return NotebookView(
            id,
            key: ValueKey(id),
          );
        }),
    GoRoute(
        path: StarredView.route,
        builder: (context, state) => const StarredView()),
    GoRoute(
        path: DeletedView.route,
        builder: (context, state) => const DeletedView()),
    // GoRoute(
    //   parentNavigatorKey: shellNavigatorKey,
    //   path: SettingsView.routeName,
    //   builder: (context, state) => const SettingsView(),
    // ),
  ];
  ref.watch(sessionProvider);
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) {
        final isLoggedIn = ref.read(sessionProvider.notifier).isLoggedIn;
        final currentRoute = state.fullPath;

        if (isLoggedIn &&
            loggedOutRoutes.where((x) => x.path == currentRoute).isNotEmpty) {
          return DashboardView.route;
        }

        if (!isLoggedIn &&
            loggedInRoutes.where((x) => x.path == currentRoute).isNotEmpty) {
          return SignInView.route;
        }

        return null;
      },
      routes: [
        ...loggedOutRoutes,
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          parentNavigatorKey: rootNavigatorKey,
          routes: loggedInRoutes,
          builder: (ctx, state, child) => SideMenuNav(child),
        ),
      ],
      initialLocation: SignInView.route);
}

extension RouterExtension on GoRouter {
  String get currentPath => this.routeInformationProvider.value.uri.path;

  bool isRoute(String route) {
    return currentPath == route;
  }
}
