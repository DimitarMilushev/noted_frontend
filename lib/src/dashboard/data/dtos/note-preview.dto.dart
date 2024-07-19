import 'package:freezed_annotation/freezed_annotation.dart';

part 'note-preview.dto.freezed.dart';
part 'note-preview.dto.g.dart';

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
