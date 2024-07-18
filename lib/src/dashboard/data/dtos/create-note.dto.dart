import 'package:freezed_annotation/freezed_annotation.dart';

part 'create-note.dto.freezed.dart';
part 'create-note.dto.g.dart';

@freezed
class CreateNoteDto with _$CreateNoteDto {
  factory CreateNoteDto({
    required final String title,
    required final String content,
    required final num notebookId,
  }) = _CreateNoteDto;

  factory CreateNoteDto.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteDtoFromJson(json);
}
