import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notebook.view-model.freezed.dart';
part 'notebook.view-model.g.dart';

@freezed
class NotebookViewData with _$NotebookViewData {
  factory NotebookViewData({
    required List<Notebook> notebooks,
    Notebook? selected,
  }) = _NotebookViewData;
}

@riverpod
class NotebookViewModel extends _$NotebookViewModel {
  late final DashboardService _service;

  @override
  Future<NotebookViewData> build() async {
    _service = ref.read(dashboardServiceProvider);
    final data = await _service.getNotebooks();

    return NotebookViewData(
      notebooks: data.notebooks.map(_mapFromNotebookDto).toList(),
    );
  }

  Future<void> onNotebookSelected(num id) async {
    if (!state.hasValue) return Future.value();

    final int index = state.value!.notebooks.indexWhere((nb) => nb.id == id);
    //TODO: error
    if (index == -1) return Future.value();

    state = const AsyncLoading();
    final notesDto = await _service.getNotesPreviewByNotebookId(id);
    final notes = notesDto.notes.map(_mapFromNotePreviewDto).toList();
    final List<Notebook> modified = List.from(state.value!.notebooks);
    final selected = modified[index].copyWith(notes: notes);
    modified[index] = selected;

    state = AsyncData(
      state.value!.copyWith(notebooks: modified, selected: selected),
    );
  }

  NoteRef _mapFromNotePreviewDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        text: dto.text,
        lastUpdated: dto.lastUpdated,
      );

  Notebook _mapFromNotebookDto(NotebookDto dto) =>
      Notebook(id: dto.id, title: dto.title, lastUpdated: dto.lastUpdated);

  Notebook? get selectedNotebook => state.unwrapPrevious().value?.selected;
}
