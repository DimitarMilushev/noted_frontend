import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.model.freezed.dart';

@freezed
class NoteRef with _$NoteRef {
  factory NoteRef({
    required num id,
    required String title,
    required String content,
    required DateTime lastUpdated,
    required DateTime dateCreated,
  }) = _NoteRef;
}
