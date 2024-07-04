import 'package:noted_frontend/src/dashboard/data/dashboard.repository.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/update-note.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard.service.g.dart';

@riverpod
DashboardService dashboardService(DashboardServiceRef ref) =>
    DashboardService(repository: ref.read(dashboardRepositoryProvider));

class DashboardService {
  final DashboardRepository _repository;
  DashboardService({required DashboardRepository repository})
      : _repository = repository;

  Future<LoadDashboardDataDto> getDashboardData() {
    return _repository.loadDashboardData();
  }

  Future getLastUsedNotes() {
    throw UnimplementedError();
  }

  Future getDeletedNotes() {
    throw UnimplementedError();
  }

  Future getStarredNotes() {
    throw UnimplementedError();
  }

  Future<NotebooksBasicDataDto> getNotebooksBasicData() {
    return _repository.getNotebooksBasicData();
  }

  Future<NotebookDetailsDto> getNotesPreviewByNotebookId(num id) {
    return _repository.getNotesPreviewByNotebookId(id);
  }

  //TODO: change when segmentated
  Future<NotePreviewDto> getNoteDetailsById(num id) {
    return _repository.getNoteDetailsById(id);
  }

  Future<NotePreviewDto> saveNoteContentById(num id,
      {String? title, String? content}) {
    return _repository.saveNoteContentById(id, title: title, content: content);
  }
}
