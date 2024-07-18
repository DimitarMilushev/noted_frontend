import 'package:freezed_annotation/freezed_annotation.dart';

part 'create-notebook.dto.freezed.dart';
part 'create-notebook.dto.g.dart';

@freezed
class CreateNotebookDto with _$CreateNotebookDto {
  factory CreateNotebookDto({
    required final String title,
  }) = _CreateNotebookDto;

  factory CreateNotebookDto.fromJson(Map<String, dynamic> json) =>
      _$CreateNotebookDtoFromJson(json);
}
