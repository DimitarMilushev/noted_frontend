import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/side-menu-nav.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/deleted.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/starred.view.dart';
import 'package:noted_frontend/src/shared/components/common-dialog.component.dart';
import 'package:noted_frontend/src/shared/components/loader-screen.component.dart';
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
        loading: LoaderScreen.dimmed,
        data: (data) => Row(
              children: [
                SideMenu(
                  style: SideMenuStyle(displayMode: _getDefaultDisplayMode()),
                  showToggle: true,
                  collapseWidth: 760,
                  controller: ref
                      .watch(sideMenuNavViewModelProvider.notifier)
                      .controller,
                  title: const _SideNavHeader(),
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
                decoration:
                    const InputDecoration(hintText: 'New notebook title'),
              ),
              primaryAction: DialogActionData(
                  text: "Create",
                  onTap: () async {
                    await ref
                        .read(sideMenuNavViewModelProvider.notifier)
                        .onCreateNotebook(titleController.text);
                    if (mounted) {
                      ctx.pop();
                    }
                  }),
            ));
  }
}

class _SideNavHeader extends ConsumerStatefulWidget {
  const _SideNavHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SideNavHeaderState();
}

class __SideNavHeaderState extends ConsumerState<_SideNavHeader> {
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
            icon: const Icon(Icons.edit_document),
            tooltip: 'Create new note',
            onPressed: _onCreateNotePressed,
          ),
        ),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
      ])
    ]);
  }

  Future _onCreateNotePressed() {
    final TextEditingController titleController = TextEditingController();
    final HtmlEditorController bodyController = HtmlEditorController();
    final List<Notebook> list =
        ref.watch(sideMenuNavViewModelProvider).value!.notebooks;
    Notebook dropdownValue = list.first;
    //TODO: adjust for 0 notebooks
    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, _, __) {
          return CommonDialogComponent(
            body: Column(
              children: [
                DropdownMenu<Notebook>(
                    initialSelection: list.first,
                    onSelected: (Notebook? value) {
                      // This is called when the user selects an item.
                      if (value == null) return;
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<Notebook>>((Notebook value) {
                      return DropdownMenuEntry<Notebook>(
                          value: value, label: value.title);
                    }).toList()),
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
                  otherOptions: const OtherOptions(height: 264),
                ),
              ],
            ),
            primaryAction: DialogActionData(
                text: "Create",
                onTap: () async {
                  await ref
                      .read(sideMenuNavViewModelProvider.notifier)
                      .onCreateNote(
                        titleController.text,
                        await bodyController.getText(),
                        dropdownValue.id,
                      );
                  if (ctx.mounted) {
                    ctx.pop();
                  }
                }),
          );
        });
  }
}
