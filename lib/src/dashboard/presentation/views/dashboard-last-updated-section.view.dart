import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';

class DashboardLastUpdatedSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = _notes(_notesMock);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last updated",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Divider(),
                  ])),
          SizedBox.fromSize(
              size: Size.fromHeight(246),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => notes[index],
                separatorBuilder: (_, index) => SizedBox.fromSize(
                  size: Size.fromWidth(24),
                ),
                itemCount: notes.length,
              ))
        ]));
  }

  List<NotePreviewCard> _notes(List<NoteRef> notes) {
    return notes
        .map((x) => NotePreviewCard(NotePreviewCardData(
              id: x.id,
              content: x.content,
              title: x.title,
              lastUpdated: x.lastUpdated,
            )))
        .toList();
  }

  List<NoteRef> _notesMock = [
    NoteRef(
        id: 1,
        title: 'title',
        content: 'asdasd',
        lastUpdated: DateTime.now(),
        dateCreated: DateTime.now()),
    NoteRef(
        id: 2,
        title: 'title',
        content: 'asdasd',
        lastUpdated: DateTime.now(),
        dateCreated: DateTime.now()),
    NoteRef(
        id: 3,
        title: 'title',
        content: 'asdasd',
        lastUpdated: DateTime.now(),
        dateCreated: DateTime.now()),
    NoteRef(
        id: 4,
        title: 'title',
        content: 'asdasd',
        lastUpdated: DateTime.now(),
        dateCreated: DateTime.now()),
    NoteRef(
        id: 5,
        title: 'title',
        content: 'asdasd',
        lastUpdated: DateTime.now(),
        dateCreated: DateTime.now()),
  ];
}
