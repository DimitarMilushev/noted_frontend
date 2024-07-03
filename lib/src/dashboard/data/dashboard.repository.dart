import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
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
}
