import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
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
    final request = await _client.get("/api/v1/users/dashboard-data");
    return LoadDashboardDataDto.fromJson(request.data);
  }

  Future<NotebooksDto> getBasicNotebooksData() {
    final list = [
      NotebookDto(id: 1, title: "Notebook", lastUpdated: DateTime(2022)),
      NotebookDto(id: 2, title: "Notebook #2", lastUpdated: DateTime(2023)),
      NotebookDto(id: 3, title: "Notebook #3", lastUpdated: DateTime(2024)),
    ];
    return Future.delayed(
      Durations.extralong1,
      () => NotebooksDto(notebooks: list),
    );
  }

  Future<NotesPreviewDto> getNotesPreviewByNotebookId(num id) {
    final list = [
      NotePreviewDto(
          id: 1,
          title: "Notebook",
          text: "Ipsum lorem",
          lastUpdated: DateTime(2022)),
      NotePreviewDto(
          id: 2, title: "Notebook #2", text: "", lastUpdated: DateTime(2023)),
      NotePreviewDto(
          id: 3, title: "Notebook #3", text: "", lastUpdated: DateTime(2024)),
    ];

    return Future.delayed(
      Durations.extralong1,
      () => NotesPreviewDto(notes: list),
    );
  }
}
