import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/notebook.view-model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';

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
    final viewState = ref.watch(notebookViewModelProvider.call(widget.id));

    return SafeArea(
      child: viewState.when(
          error: (err, st) => SizedBox(child: Text(err.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(48),
                    child: SizedBox.fromSize(
                      size: const Size.fromHeight(256),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: TextEditingController(
                                text: data.title,
                              ),
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
                    child: Wrap(
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
