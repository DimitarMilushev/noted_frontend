import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/dashboard-last-updated.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/note.view-model.dart';
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
  late final DashboardService _service = ref.read(dashboardServiceProvider);
  final List<String> _options = List.empty(growable: true);
  final SideMenuController _sideMenuController = SideMenuController();

  SideMenuController get controller => _sideMenuController;

  @override
  Future<SideMenuNavData> build() async {
    final data = await _service.getNotebooksBasicData();
    final sortedData = _sortNotebooksByLastUpdatedDate(data.notebooks);
    _initOptions(sortedData);
    ref
        .read(routerProvider)
        .routerDelegate
        .addListener(() => _sideMenuController.changePage(indexOfSelected()));
    return SideMenuNavData(
        notebooks: sortedData.map(_mapFromNotebookDto).toList());
  }

  Future<void> onCreateNotebook(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final added = await _service.createNotebook(title);
      final listCopy = List.of([
        Notebook(
          id: added.id,
          title: added.title,
          lastUpdated: added.lastUpdated,
          dateCreated: added.dateCreated,
        ),
        ...state.value!.notebooks,
      ]);

      return state.value!.copyWith(notebooks: listCopy);
    });
  }

  Future<void> onCreateNote(
      String title, String content, num notebookId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _service.createNote(title, content, notebookId);
      //TODO: update providers
      if (ref.read(dashboardLastUpdatedViewModelProvider).hasValue) {
        ref.invalidate(dashboardLastUpdatedViewModelProvider);
      }

      if (_selectedNotebookId != -1 &&
          ref.read(noteViewModelProvider.call(_selectedNotebookId)).hasValue) {
        ref.invalidate(noteViewModelProvider.call(_selectedNotebookId));
      }
      return state.value!;
    });
  }

  List<NotebookBasicDataDto> _sortNotebooksByLastUpdatedDate(
      List<NotebookBasicDataDto> data) {
    final copy = List.of(data)
      ..sort(
        (prev, next) => prev.lastUpdated.isAfter(next.lastUpdated) ? 1 : 0,
      );
    return copy;
  }

  int indexOfSelected() {
    final path = ref.read(routerProvider).currentPath;
    return _options.indexOf(path);
  }

//TODO:adjust
  num get _selectedNotebookId {
    final path = ref.read(routerProvider).currentPath;
    if (!path.contains(
        NotebookView.route.substring(0, NotebookView.route.lastIndexOf('/')))) {
      return -1;
    }
    return int.parse(path.substring(path.lastIndexOf('/') + 1));
  }

  void onNotebookSelected(num id) {
    ref
        .read(routerProvider)
        .go(NotebookView.route.replaceFirst(":notebookId", '$id'));
  }

  Notebook _mapFromNotebookDto(NotebookBasicDataDto dto) => Notebook(
        id: dto.id,
        title: dto.title,
        lastUpdated: dto.lastUpdated,
        dateCreated: dto.dateCreated,
      );

  void _initOptions(List<NotebookBasicDataDto> notebooks) {
    _options.clear();
    _options.add(DashboardView.route);
    for (var nb in notebooks) {
      _options.add(NotebookView.route.replaceFirst(":notebookId", '${nb.id}'));
    }
    _options.add(StarredView.route);
    _options.add(DeletedView.route);
  }
}
