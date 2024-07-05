import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/load-dashboard-data.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard.view-model.g.dart';
part 'dashboard.view-model.freezed.dart';

@freezed
class DashboardViewData with _$DashboardViewData {
  factory DashboardViewData({
    @Default([]) List<Notebook> notebooks,
    @Default(-1) num selectedNotebook,
  }) = _DashboardViewData;
}

@riverpod
class DashboardViewModel extends _$DashboardViewModel {
  late final DashboardService _service;

  @override
  Future<DashboardViewData> build() async {
    _service = ref.read(dashboardServiceProvider);
    final data = await _service.getDashboardData();

    return DashboardViewData(
      notebooks: data.notebooks.map(_mapFromDashboardNotebookDto).toList(),
    );
  }

  num get selectedNotebook => state.value!.selectedNotebook;

  void selectNotebook(num id) {
    if (selectedNotebook == id) return;
    if (!state.value!.notebooks.any((nb) => nb.id == id)) return;

    ref.read(routerProvider).go('${DashboardView.route}?notebook=$id');
    // state = AsyncData(state.value!.copyWith(selectedNotebook: id));
  }

  Notebook _mapFromDashboardNotebookDto(LoadDashboardDataNotebookDto dto) {
    return Notebook(
      id: dto.id,
      title: dto.title,
      lastUpdated: dto.lastUpdated,
      dateCreated: DateTime.now(), //TODO
      notes: dto.notes.map(_mapFromDashboardNoteDto).toList(),
    );
  }

  NoteRef _mapFromDashboardNoteDto(LoadDashboardDataNoteDto dto) {
    return NoteRef(
      id: dto.id,
      content: " ",
      title: dto.title,
      lastUpdated: dto.lastUpdated,
      dateCreated: DateTime.now(), //TODO
    );
  }
}
