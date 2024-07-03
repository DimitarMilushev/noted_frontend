import 'package:freezed_annotation/freezed_annotation.dart';

part 'notebooks.dto.freezed.dart';
part 'notebooks.dto.g.dart';

@freezed
class NotebooksDto with _$NotebooksDto {
  factory NotebooksDto({
    required List<NotebookDto> notebooks,
  }) = _NotebooksDto;

  factory NotebooksDto.fromJson(Map<String, dynamic> json) =>
      _$NotebooksDtoFromJson(json);
}

@freezed
class NotebookDto with _$NotebookDto {
  factory NotebookDto({
    required num id,
    required String title,
    required DateTime lastUpdated,
  }) = _NotebookDto;

  factory NotebookDto.fromJson(Map<String, dynamic> json) =>
      _$NotebookDtoFromJson(json);
}
