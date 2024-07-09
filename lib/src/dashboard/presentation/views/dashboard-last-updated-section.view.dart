import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/dashboard-last-updated.view-model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';

class DashboardLastUpdatedView extends ConsumerStatefulWidget {
  const DashboardLastUpdatedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardLastUpdatedViewState();
}

class _DashboardLastUpdatedViewState
    extends ConsumerState<DashboardLastUpdatedView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(dashboardLastUpdatedViewModelProvider);
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
              size: const Size.fromHeight(246),
              child: viewModel.when(
                  data: (data) {
                    final notes = data.map(_mapFromNoteRef).toList();
                    return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => notes[index],
                      separatorBuilder: (_, index) => SizedBox.fromSize(
                        size: const Size.fromWidth(24),
                      ),
                      itemCount: notes.length,
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, __) => Text(err.toString())))
        ]));
  }

  NotePreviewCard _mapFromNoteRef(NoteRef data) =>
      NotePreviewCard(NotePreviewCardData(
        id: data.id,
        content: data.content,
        title: data.title,
        lastUpdated: data.lastUpdated,
      ));
}
