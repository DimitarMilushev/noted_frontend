import 'package:freezed_annotation/freezed_annotation.dart';

part 'update-notebook-title-response.dto.freezed.dart';
part 'update-notebook-title-response.dto.g.dart';

@freezed
class UpdateNotebookTitleResponseDto with _$UpdateNotebookTitleResponseDto {
  factory UpdateNotebookTitleResponseDto({
    required String title,
    required DateTime lastUpdated,
  }) = _UpdateNotebookTitleResponseDto;

  factory UpdateNotebookTitleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotebookTitleResponseDtoFromJson(json);
}
