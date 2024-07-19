import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/data/dtos/note-preview.dto.dart';

part 'notebook-details.dto.freezed.dart';
part 'notebook-details.dto.g.dart';

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
