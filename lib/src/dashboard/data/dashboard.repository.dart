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
    // final response = await _client.get("/api/v1/users/dashboard-data");
    // return LoadDashboardDataDto.fromJson(response.data);
    return dashboardData;
  }

  Future<NotebooksBasicDataDto> getNotebooksBasicData() async {
    // final response = await _client.get('/api/v1/notebooks/all');
    // return NotebooksBasicDataDto.fromJson({'notebooks': response.data});
    return NotebooksBasicDataDto(notebooks: notebookBasicDataList);
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

var notebookBasicDataList = [
  NotebookBasicDataDto(
    id: 1,
    title: 'Notebook 1',
    lastUpdated: DateTime.now().subtract(Duration(days: 5)),
    dateCreated: DateTime.now().subtract(Duration(days: 30)),
  ),
  NotebookBasicDataDto(
    id: 2,
    title: 'Notebook 2',
    lastUpdated: DateTime.now().subtract(Duration(days: 10)),
    dateCreated: DateTime.now().subtract(Duration(days: 60)),
  ),
  NotebookBasicDataDto(
    id: 3,
    title: 'Notebook 3',
    lastUpdated: DateTime.now().subtract(Duration(days: 15)),
    dateCreated: DateTime.now().subtract(Duration(days: 90)),
  ),
];

var dashboardData = LoadDashboardDataDto(
  id: 1,
  notebooks: [
    LoadDashboardDataNotebookDto(
      id: 1,
      title: 'Notebook 1',
      lastUpdated: DateTime.now().subtract(Duration(days: 5)),
      notes: [
        LoadDashboardDataNoteDto(
          id: 1,
          title: 'Note 1',
          lastUpdated: DateTime.now().subtract(Duration(days: 1)),
        ),
        LoadDashboardDataNoteDto(
          id: 2,
          title: 'Note 2',
          lastUpdated: DateTime.now().subtract(Duration(days: 2)),
        ),
      ],
    ),
    LoadDashboardDataNotebookDto(
      id: 2,
      title: 'Notebook 2',
      lastUpdated: DateTime.now().subtract(Duration(days: 6)),
      notes: [
        LoadDashboardDataNoteDto(
          id: 3,
          title: 'Note 3',
          lastUpdated: DateTime.now().subtract(Duration(days: 3)),
        ),
        LoadDashboardDataNoteDto(
          id: 4,
          title: 'Note 4',
          lastUpdated: DateTime.now().subtract(Duration(days: 4)),
        ),
      ],
    ),
  ],
);
  // Add more LoadDashboardDataDto objects if needed

