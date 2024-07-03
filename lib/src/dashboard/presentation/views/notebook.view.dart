import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/notebook.view-model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';

class NotebookView extends ConsumerStatefulWidget {
  static const String route = '/notebook/:notebookId';
  final num? id;
  const NotebookView(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotebookViewState();
}

class _NotebookViewState extends ConsumerState<NotebookView> {
  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(notebookViewModelProvider);
    return SafeArea(
      child: viewState.when(
        error: (err, st) => SizedBox(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox.fromSize(
                  size: const Size.fromHeight(256),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                              "https://cdn.mos.cms.futurecdn.net/xaycNDmeyxpHDrPqU6LmaD-970-80.jpg.webp")),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Wrap(
                  runSpacing: 24,
                  spacing: 24,
                  children: [..._notes(data)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Iterable<NotePreviewCard> _notes(NotebookViewData data) {
    if (data.selected == null) return [];
    final notes = data.notebooks
        .firstWhere(
          (x) => x.id == data.selected!.id,
        )
        .notes;

    return notes!.map((x) => NotePreviewCard(NotePreviewCardData(
          id: x.id,
          text: x.text,
          title: x.title,
          lastUpdated: x.lastUpdated,
        )));
  }
}
