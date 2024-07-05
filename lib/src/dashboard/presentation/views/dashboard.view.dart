import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/dashboard.view-model.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';

class DashboardView extends ConsumerStatefulWidget {
  static String route = "/dashboard";
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late final DashboardViewModel controller;
  @override
  void initState() {
    controller = ref.read(dashboardViewModelProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(dashboardViewModelProvider);
    return SafeArea(
      child: viewState.when(
        error: (err, st) => SizedBox(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox.fromSize(
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
                          style:
                              Theme.of(context).primaryTextTheme.displayLarge,
                        ),
                      ),
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

  Iterable<NotePreviewCard> _notes(DashboardViewData data) {
    if (data.selectedNotebook == -1) return [];
    final notes = data.notebooks
        .firstWhere(
          (x) => x.id == data.selectedNotebook,
        )
        .notes;
    return notes.map((x) => NotePreviewCard(NotePreviewCardData(
          id: x.id,
          content: x.content,
          title: x.title,
          lastUpdated: x.lastUpdated,
        )));
  }

  Iterable<NotePreviewCard> buildCards(List<NotePreviewCardData> data) {
    return data.map((x) => NotePreviewCard(x));
  }
}
