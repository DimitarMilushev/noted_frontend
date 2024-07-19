import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/note-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/dashboard-last-updated.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note.view-model.g.dart';
part 'note.view-model.freezed.dart';

@freezed
class NoteViewData with _$NoteViewData {
  factory NoteViewData({
    required NoteRef noteData,
    @Default(false) bool isSaving,
  }) = _NoteViewData;
}

@riverpod
class NoteViewModel extends _$NoteViewModel {
  late final DashboardService _service;

  bool get isSaving => state.value?.isSaving ?? false;

  @override
  FutureOr<NoteViewData> build(num id) async {
    _service = ref.read(dashboardServiceProvider);
    final dto = await _service.getNoteDetailsById(id);

    return NoteViewData(noteData: _mapFromNoteDetailsDto(dto));
  }

  NoteRef _mapFromNoteDetailsDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        content: dto.content,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
      );

  Future onDeletePressed() async {
    final stateSnapshot = state.value!;
    state = const AsyncLoading();
    try {
      await _service.deleteNote(id);
      if (ref.read(dashboardLastUpdatedViewModelProvider).hasValue) {
        ref.invalidate(dashboardLastUpdatedViewModelProvider);
      }
      ref.read(routerProvider).canPop()
          ? ref.read(routerProvider).pop()
          : ref.read(routerProvider).go(DashboardView.route);
    } catch (ex) {
      state = AsyncData(stateSnapshot);
    }
  }

  Future<void> onSavePressed(String fieldTitle, String fieldContent) async {
    if (!state.unwrapPrevious().hasValue || state.isLoading) return;

    state = AsyncData(state.value!.copyWith(isSaving: true));
    state = await AsyncValue.guard(() async {
      final updated = await _service.saveNoteChangesById(
        state.value!.noteData.id,
        title: state.value!.noteData.title != fieldTitle ? fieldTitle : null,
        content:
            state.value!.noteData.content != fieldContent ? fieldContent : null,
      );
      return state.value!.copyWith(
        noteData: _mapFromNoteDetailsDto(updated),
        isSaving: false,
      );
    });
  }
}
