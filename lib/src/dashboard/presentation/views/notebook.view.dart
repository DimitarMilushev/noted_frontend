import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/notebook.view-model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';
import 'package:noted_frontend/src/shared/components/popup-menu-icon-option.component.dart';

class NotebookView extends ConsumerStatefulWidget {
  static const String route = '/notebook/:notebookId';
  final int id;
  const NotebookView(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotebookViewState();
}

class _NotebookViewState extends ConsumerState<NotebookView> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final viewState = ref.watch(notebookViewModelProvider.call(widget.id));

    return SafeArea(
      child: viewState.when(
          error: (err, st) => SizedBox(child: Text(err.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) {
            titleController.text = data.title;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: _NotebookViewPopupMenu(widget.id, titleController),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(48),
                    child: SizedBox.fromSize(
                      size: const Size.fromHeight(256),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: titleController,
                              style: Theme.of(context).textTheme.displayLarge,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            Text('Date created: ${data.dateCreated}'),
                            Text('Last updated: ${data.lastUpdated}'),
                          ]),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 960),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: data.notes.isEmpty
                        ? Center(
                            child: Text(
                              "No notes added yet...",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.grey),
                            ),
                          )
                        : Wrap(
                            runSpacing: 24,
                            spacing: 24,
                            children: [..._notes(data.notes)],
                          ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Iterable<NotePreviewCard> _notes(List<NoteRef> notes) {
    return notes.map((x) => NotePreviewCard(NotePreviewCardData(
          id: x.id,
          content: x.content,
          title: x.title,
          lastUpdated: x.lastUpdated,
        )));
  }
}

class _NotebookViewPopupMenu extends ConsumerWidget {
  final int id;
  final TextEditingController titleController;

  const _NotebookViewPopupMenu(this.id, this.titleController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: ref
                      .read(notebookViewModelProvider.call(id).notifier)
                      .onDeletePressed,
                  child: const PopupMenuIconOption(
                    label: "Remove",
                    icon: Icons.remove,
                  )),
              PopupMenuItem(
                  onTap: () => ref
                      .read(notebookViewModelProvider.call(id).notifier)
                      .onSavePressed(titleController.value.text),
                  child: const PopupMenuIconOption(
                    label: "Save",
                    icon: Icons.save,
                  )),
            ]);
  }
}
