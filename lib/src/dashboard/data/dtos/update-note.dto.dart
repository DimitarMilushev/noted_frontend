import 'package:freezed_annotation/freezed_annotation.dart';

part 'update-note.dto.freezed.dart';
part 'update-note.dto.g.dart';

@freezed
class UpdateNoteDto with _$UpdateNoteDto {
  factory UpdateNoteDto({
    String? title,
    String? content,
  }) = _UpdateNoteDto;

  factory UpdateNoteDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteDtoFromJson(json);
}
