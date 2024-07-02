import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard-view.data.freezed.dart';

@freezed
class DashboardViewData with _$DashboardViewData {
  factory DashboardViewData({
    List<Notebook>? notebooks,
    @Default(null) num? selectedNotebook,
  }) = _DashboardViewData;
}

@freezed
class Notebook with _$Notebook {
  factory Notebook({
    required num id,
    required String title,
    required DateTime lastUpdated,
  }) = _Notebook;
}
