import 'package:dio/dio.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
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
}
