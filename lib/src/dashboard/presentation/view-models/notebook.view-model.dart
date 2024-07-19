import 'dart:async';

import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/note-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebook-details.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/side-menu-nav.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notebook.view-model.g.dart';

@riverpod
class NotebookViewModel extends _$NotebookViewModel {
  late final DashboardService _service;

  @override
  Future<Notebook> build(int id) async {
    _service = ref.read(dashboardServiceProvider);

    final payload = await _service.getNotesPreviewByNotebookId(id);
    return _mapFromNotebookDetailsDto(payload);
  }

  Future<void> onDeletePressed() async {
    if (!state.hasValue) return;
    final stateSnapshot = state.value!;
    state = const AsyncLoading();
    try {
      await _service.deleteNotebook(id);
      ref.invalidate(sideMenuNavViewModelProvider);
      ref.read(routerProvider).go(DashboardView.route);
    } catch (err) {
      //TODO: error modal
      state = AsyncData(stateSnapshot);
    }
  }

  Future<void> onSavePressed(String changedTitle) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updated = await _service.saveNotebookChanges(id, changedTitle);
      ref.invalidate(sideMenuNavViewModelProvider);
      return state.value!
          .copyWith(title: updated.title, lastUpdated: updated.lastUpdated);
    });
  }

  Notebook _mapFromNotebookDetailsDto(NotebookDetailsDto dto) => Notebook(
        id: dto.id,
        title: dto.title,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
        notes: dto.notes.map(_mapFromNotePreviewDto).toList(),
      );

  NoteRef _mapFromNotePreviewDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        content: dto.content,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
      );
}
