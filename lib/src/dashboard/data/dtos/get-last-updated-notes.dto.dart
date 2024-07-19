import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/note-preview.dto.dart';

part 'get-last-updated-notes.dto.freezed.dart';
part 'get-last-updated-notes.dto.g.dart';

@freezed
class GetLastUpdatedNotesDto with _$GetLastUpdatedNotesDto {
  factory GetLastUpdatedNotesDto({
    required List<NotePreviewDto> notes,
  }) = _GetLastUpdatedNotesDto;

  factory GetLastUpdatedNotesDto.fromJson(Map<String, dynamic> json) =>
      _$GetLastUpdatedNotesDtoFromJson(json);
}
