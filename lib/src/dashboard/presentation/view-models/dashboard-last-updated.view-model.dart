import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard-last-updated.view-model.g.dart';

@riverpod
class DashboardLastUpdatedViewModel extends _$DashboardLastUpdatedViewModel {
  late final DashboardService _service;

  @override
  FutureOr<List<NoteRef>> build() async {
    _service = ref.read(dashboardServiceProvider);

    final response = await _service.getLastUpdatedNotes();
    return response.map(_mapFromNoteDetailsDto).toList();
  }

  NoteRef _mapFromNoteDetailsDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        content: dto.content,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
      );
}
