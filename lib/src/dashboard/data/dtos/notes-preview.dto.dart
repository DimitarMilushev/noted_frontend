import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes-preview.dto.freezed.dart';
part 'notes-preview.dto.g.dart';

@freezed
class NotebookDetailsDto with _$NotebookDetailsDto {
  factory NotebookDetailsDto({
    required num id,
    required String title,
    required DateTime lastUpdated,
    required DateTime dateCreated,
    required List<NotePreviewDto> notes,
  }) = _NotesPreviewDto;

  factory NotebookDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$NotebookDetailsDtoFromJson(json);
}

@freezed
class NotePreviewDto with _$NotePreviewDto {
  factory NotePreviewDto({
    required num id,
    required String title,
    required String content,
    required DateTime lastUpdated,
    required DateTime dateCreated,
  }) = _NotePreviewDto;

  factory NotePreviewDto.fromJson(Map<String, dynamic> json) =>
      _$NotePreviewDtoFromJson(json);
}
