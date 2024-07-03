import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks.dto.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notes-preview.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/deleted.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/notebook.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/starred.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'side-menu-nav.view-model.freezed.dart';
part 'side-menu-nav.view-model.g.dart';

@freezed
class SideMenuNavData with _$SideMenuNavData {
  factory SideMenuNavData({
    required List<Notebook> notebooks,
    Notebook? selected,
  }) = _SideMenuNavData;
}

@riverpod
class SideMenuNavViewModel extends _$SideMenuNavViewModel {
  late final DashboardService _service;
  late final List<String> options;
  @override
  Future<SideMenuNavData> build() async {
    _service = ref.read(dashboardServiceProvider);
    final data = await _service.getNotebooks();
    _initOptions(data.notebooks);
    return SideMenuNavData(
      notebooks: data.notebooks.map(_mapFromNotebookDto).toList(),
    );
  }

  int indexOfSelected() {
    final path = ref.read(routerProvider).currentPath;
    return options.indexOf(path);
  }

  void onNotebookSelected(num id) {
    ref
        .read(routerProvider)
        .go(NotebookView.route.replaceFirst(":notebookId", '$id'));
  }

  NoteRef _mapFromNotePreviewDto(NotePreviewDto dto) => NoteRef(
        id: dto.id,
        title: dto.title,
        text: dto.text,
        lastUpdated: dto.lastUpdated,
      );

  Notebook _mapFromNotebookDto(NotebookDto dto) =>
      Notebook(id: dto.id, title: dto.title, lastUpdated: dto.lastUpdated);

  Notebook? get selectedNotebook => state.unwrapPrevious().value?.selected;

  void _initOptions(List<NotebookDto> notebooks) {
    options = List.empty(growable: true);
    options.add(DashboardView.route);
    for (var nb in notebooks) {
      options.add(NotebookView.route.replaceFirst(":notebookId", '${nb.id}'));
    }
    options.add(StarredView.route);
    options.add(DeletedView.route);
  }
}
