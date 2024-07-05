import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/notebooks-basic-data.dto.dart';
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
  late final List<String> _options;
  final SideMenuController _sideMenuController = SideMenuController();

  @override
  bool updateShouldNotify(
      AsyncValue<SideMenuNavData> previous, AsyncValue<SideMenuNavData> next) {
    if (state.unwrapPrevious().hasValue) {
      _sideMenuController.changePage(indexOfSelected());
    }
    return super.updateShouldNotify(previous, next);
  }

  SideMenuController get controller => _sideMenuController;

  @override
  Future<SideMenuNavData> build() async {
    _service = ref.read(dashboardServiceProvider);
    final data = await _service.getNotebooksBasicData();
    _initOptions(data.notebooks);
    return SideMenuNavData(
      notebooks: data.notebooks.map(_mapFromNotebookDto).toList(),
    );
  }

  int indexOfSelected() {
    final path = ref.read(routerProvider).currentPath;
    return _options.indexOf(path);
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

  Notebook? get selectedNotebook => state.unwrapPrevious().value?.selected;

  void _initOptions(List<NotebookBasicDataDto> notebooks) {
    _options = List.empty(growable: true);
    _options.add(DashboardView.route);
    for (var nb in notebooks) {
      _options.add(NotebookView.route.replaceFirst(":notebookId", '${nb.id}'));
    }
    _options.add(StarredView.route);
    _options.add(DeletedView.route);
  }
}