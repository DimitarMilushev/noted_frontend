import 'package:freezed_annotation/freezed_annotation.dart';

part 'load-dashboard-data.dto.freezed.dart';
part 'load-dashboard-data.dto.g.dart';

@freezed
class LoadDashboardDataDto with _$LoadDashboardDataDto {
  factory LoadDashboardDataDto({
    required num id,
    required List<LoadDashboardDataNotebookDto> notebooks,
  }) = _LoadDashboardDataDto;

  factory LoadDashboardDataDto.fromJson(Map<String, dynamic> json) =>
      _$LoadDashboardDataDtoFromJson(json);
}

@freezed
class LoadDashboardDataNotebookDto with _$LoadDashboardDataNotebookDto {
  const factory LoadDashboardDataNotebookDto({
    required num id,
    required String title,
    required DateTime lastUpdated,
    required List<LoadDashboardDataNoteDto> notes,
  }) = _LoadDashboardDataNotebookDto;

  factory LoadDashboardDataNotebookDto.fromJson(Map<String, dynamic> json) =>
      _$LoadDashboardDataNotebookDtoFromJson(json);
}

@freezed
class LoadDashboardDataNoteDto with _$LoadDashboardDataNoteDto {
  const factory LoadDashboardDataNoteDto({
    required num id,
    required String title,
    required DateTime lastUpdated,
  }) = _LoadDashboardDataNoteDto;

  factory LoadDashboardDataNoteDto.fromJson(Map<String, dynamic> json) =>
      _$LoadDashboardDataNoteDtoFromJson(json);
}
