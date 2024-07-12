import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/side-menu-nav.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/deleted.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/starred.view.dart';
import 'package:noted_frontend/src/shared/components/common-dialog.component.dart';
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
                  title: _SideMenuHeader(),
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
                        children: [
                          SideMenuItem(
                            title: "Create Notebook",
                            onTap: (_, __) => _onCreateNotebookPressed(),
                          ),
                          ..._getNotebookItems(data)
                        ]),
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

  Future _onCreateNotebookPressed() {
    final TextEditingController titleController = TextEditingController();

    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, _, __) => CommonDialogComponent(
              body: TextField(
                controller: titleController,
                style: Theme.of(ctx)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(hintText: 'New note title'),
              ),
              primaryAction: DialogActionData(
                  text: "Create",
                  onTap: () {
                    ctx.pop();
                  }),
            ));
  }
}

class _SideMenuHeader extends StatelessWidget {
  const _SideMenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
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
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.edit_document),
            tooltip: 'Create new note',
            onPressed: () => _onCreateNotebookPressed(context),
          ),
        ),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
      ])
    ]);
  }

  Future _onCreateNotebookPressed(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final HtmlEditorController bodyController = HtmlEditorController();
    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, _, __) {
          return CommonDialogComponent(
            body: Column(
              children: [
                TextField(
                  controller: titleController,
                  style: Theme.of(ctx)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(hintText: 'New note title'),
                ),
                HtmlEditor(
                  controller: bodyController,
                  otherOptions: OtherOptions(height: 264),
                ),
              ],
            ),
            primaryAction: DialogActionData(
                text: "Create",
                onTap: () {
                  ctx.pop();
                }),
          );
        });
  }
}
