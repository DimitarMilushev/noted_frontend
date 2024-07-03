import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes-preview.dto.freezed.dart';
part 'notes-preview.dto.g.dart';

@freezed
class NotesPreviewDto with _$NotesPreviewDto {
  factory NotesPreviewDto({
    required List<NotePreviewDto> notes,
  }) = _NotesPreviewDto;

  factory NotesPreviewDto.fromJson(Map<String, dynamic> json) =>
      _$NotesPreviewDtoFromJson(json);
}

@freezed
class NotePreviewDto with _$NotePreviewDto {
  factory NotePreviewDto({
    required num id,
    required String title,
    required String text,
    required DateTime lastUpdated,
  }) = _NotePreviewDto;

  factory NotePreviewDto.fromJson(Map<String, dynamic> json) =>
      _$NotePreviewDtoFromJson(json);
}
