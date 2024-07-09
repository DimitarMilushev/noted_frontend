import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard-last-updated-section.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard-support-section.view.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';

class DashboardView extends ConsumerStatefulWidget {
  static String route = "/dashboard";
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _DashboardHeader(),
          DashboardLastUpdatedView(),
          DashboardSupportSection(),
        ],
      ),
    );
  }
}

class _DashboardHeader extends ConsumerWidget {
  const _DashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.fromSize(
        size: const Size.fromHeight(256),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                    "https://cdn.mos.cms.futurecdn.net/xaycNDmeyxpHDrPqU6LmaD-970-80.jpg.webp")),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Welcome back, ${ref.watch(sessionProvider).value?.username}!",
                style: Theme.of(context).primaryTextTheme.displayLarge,
              ),
            ),
          ),
        ));
  }
}
