import 'package:freezed_annotation/freezed_annotation.dart';

part 'update-notebook-title.dto.freezed.dart';
part 'update-notebook-title.dto.g.dart';

@freezed
class UpdateNotebookTitleDto with _$UpdateNotebookTitleDto {
  factory UpdateNotebookTitleDto({
    required String title,
  }) = _UpdateNotebookTitleDto;

  factory UpdateNotebookTitleDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotebookTitleDtoFromJson(json);
}
