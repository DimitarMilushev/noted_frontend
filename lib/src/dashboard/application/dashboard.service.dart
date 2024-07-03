import 'package:noted_frontend/src/dashboard/data/dashboard.repository.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
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

  Future<NotebooksBasicDataDto> getNotebooks() {
    return _repository.getNotebooksBasicData();
  }

  Future<NotebookDetailsDto> getNotesPreviewByNotebookId(num id) {
    return _repository.getNotesPreviewByNotebookId(id);
  }
}
