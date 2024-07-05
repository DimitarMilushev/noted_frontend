import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
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
