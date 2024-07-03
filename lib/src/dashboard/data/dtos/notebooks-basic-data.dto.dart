import 'package:freezed_annotation/freezed_annotation.dart';

part 'notebooks-basic-data.dto.freezed.dart';
part 'notebooks-basic-data.dto.g.dart';

@freezed
class NotebooksBasicDataDto with _$NotebooksBasicDataDto {
  factory NotebooksBasicDataDto({
    required List<NotebookBasicDataDto> notebooks,
  }) = _NotebooksBasicDataDto;

  factory NotebooksBasicDataDto.fromJson(Map<String, dynamic> json) =>
      _$NotebooksBasicDataDtoFromJson(json);
}

@freezed
class NotebookBasicDataDto with _$NotebookBasicDataDto {
  factory NotebookBasicDataDto({
    required num id,
    required String title,
    required DateTime lastUpdated,
    required DateTime dateCreated,
  }) = _NotebookBasicDataDto;

  factory NotebookBasicDataDto.fromJson(Map<String, dynamic> json) =>
      _$NotebookBasicDataDtoFromJson(json);
}
