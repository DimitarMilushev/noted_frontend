import 'dart:async';

import 'package:noted_frontend/src/dashboard/data/dashboard.repository.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/note-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebook-details.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/update-notebook-title-response.dto.dart';
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

  Future<NotebookBasicDataDto> createNotebook(String title) {
    return _repository.createNotebook(title);
  }

  Future<void> deleteNotebook(num id) async {
    await _repository.deleteNotebook(id);
  }

  Future<void> createNote(String title, String content, num notebookId) async {
    await _repository.createNote(title, content, notebookId);
  }

  Future<void> deleteNote(num id) async {
    await _repository.deleteNote(id);
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

  Future<NotePreviewDto> saveNoteChangesById(num id,
      {String? title, String? content}) {
    return _repository.saveNoteChangesById(id, title: title, content: content);
  }

  Future<List<NotePreviewDto>> getLastUpdatedNotes() {
    return _repository.getLastUpdatedNotes();
  }

  Future<UpdateNotebookTitleResponseDto> saveNotebookChanges(
      int id, String title) {
    return _repository.saveNotebookTitle(id, title);
  }
}
