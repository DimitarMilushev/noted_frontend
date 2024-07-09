import 'package:dio/dio.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/get-last-updated-notes.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/update-note.dto.dart';
import 'package:noted_frontend/src/shared/dio.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard.repository.g.dart';

@Riverpod()
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) =>
    DashboardRepository(client: ref.read(dioProvider));

class DashboardRepository {
  final Dio _client;
  DashboardRepository({required Dio client}) : _client = client;

  Future<LoadDashboardDataDto> loadDashboardData() async {
    final response = await _client.get("/api/v1/users/dashboard-data");
    return LoadDashboardDataDto.fromJson(response.data);
  }

  Future<NotebooksBasicDataDto> getNotebooksBasicData() async {
    final response = await _client.get('/api/v1/notebooks/all');
    return NotebooksBasicDataDto.fromJson({'notebooks': response.data});
  }

  Future<NotebookDetailsDto> getNotesPreviewByNotebookId(num id) async {
    final response = await _client.get('/api/v1/notebooks/details/$id');
    return NotebookDetailsDto.fromJson(response.data);
  }

  Future<NotePreviewDto> getNoteDetailsById(num id) async {
    final response = await _client.get('/api/v1/notes/$id');
    return NotePreviewDto.fromJson(response.data);
  }

  Future<NotePreviewDto> saveNoteContentById(num id,
      {String? title, String? content}) async {
    // if (title == null && content == null) return;
    // TODO: Shouldn't be possible
    final dto = UpdateNoteDto(title: title, content: content);
    final response = await _client.patch(
      '/api/v1/notes/$id',
      data: dto.toJson(),
    );

    return NotePreviewDto.fromJson(response.data);
  }

  Future<List<NotePreviewDto>> getLastUpdatedNotes() async {
    final response = await _client.get("/api/v1/notes/last-updated");
    return GetLastUpdatedNotesDto.fromJson({'notes': response.data}).notes;
  }
}
