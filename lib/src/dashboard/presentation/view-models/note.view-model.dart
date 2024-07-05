import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
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

  Future<void> saveChanges(String fieldTitle, String fieldContent) async {
    if (!state.unwrapPrevious().hasValue || state.isLoading) return;

    state = AsyncData(state.value!.copyWith(isSaving: true));
    state = await AsyncValue.guard(() async {
      final updated = await _service.saveNoteContentById(
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

  NoteRef _mapFromNoteDetailsDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        content: dto.content,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
      );
}
