import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/side-menu-nav.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/deleted.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/starred.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';

class SideMenuNav extends ConsumerStatefulWidget {
  final Widget child;
  const SideMenuNav(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenuNav> {
  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(sideMenuNavViewModelProvider);

    return viewState.when(
        error: (err, __) => Center(child: Text(err.toString())),
        loading: () => const CircularProgressIndicator(),
        data: (data) => Row(
              children: [
                SideMenu(
                  style: SideMenuStyle(displayMode: _getDefaultDisplayMode()),
                  showToggle: true,
                  collapseWidth: 760,
                  controller: ref
                      .watch(sideMenuNavViewModelProvider.notifier)
                      .controller,
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 150,
                        ),
                        child: Image.network(
                          'https://png.pngtree.com/png-vector/20221128/ourmid/pngtree-cream-sticky-notes-paper-illustration-with-clip-white-transparent-background-png-image_6484210.png',
                        ),
                      ),
                      const Text("Noted v1.0"),
                      const Divider(
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                    ],
                  ),
                  items: [
                    SideMenuItem(
                      onTap: (_, __) {
                        ref.read(routerProvider).go(DashboardView.route);
                      },
                      title: 'Home',
                      icon: const Icon(Icons.home),
                    ),
                    SideMenuExpansionItem(
                        icon: const Icon(Icons.book),
                        title: "Notebooks",
                        children: [..._getNotebookItems(data)]),
                    SideMenuItem(
                      onTap: (_, __) {
                        ref.read(routerProvider).go(StarredView.route);
                      },
                      title: 'Starred',
                      icon: const Icon(Icons.star),
                    ),
                    SideMenuItem(
                      onTap: (_, __) {
                        ref.read(routerProvider).go(DeletedView.route);
                      },
                      title: 'Deleted',
                      icon: const Icon(Icons.delete),
                    ),
                    SideMenuItem(
                      onTap: (_, __) {
                        ref.read(authServiceProvider).signOut();
                      },
                      title: 'Logout',
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Expanded(
                  child: widget.child,
                )
              ],
            ));
  }

  SideMenuDisplayMode _getDefaultDisplayMode() {
    // Large tablets to Desktop
    final isLargeEnoughScreen = MediaQuery.of(context).size.width >= 768;
    return isLargeEnoughScreen
        ? SideMenuDisplayMode.open
        : SideMenuDisplayMode.compact;
  }

  Iterable<SideMenuItem> _getNotebookItems(SideMenuNavData data) =>
      data.notebooks.map((x) => SideMenuItem(
            onTap: (_, __) {
              ref
                  .read(sideMenuNavViewModelProvider.notifier)
                  .onNotebookSelected(x.id);
            },
            title: x.title,
            icon: const Icon(Icons.book_outlined),
          ));
}
