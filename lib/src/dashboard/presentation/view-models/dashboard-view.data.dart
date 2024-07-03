import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/notebook.model.dart';

part 'dashboard-view.data.freezed.dart';

@freezed
class DashboardViewData with _$DashboardViewData {
  factory DashboardViewData({
    @Default([]) List<Notebook> notebooks,
    @Default(-1) num selectedNotebook,
    @Default(-1) num selectedNote,
  }) = _DashboardViewData;
}
