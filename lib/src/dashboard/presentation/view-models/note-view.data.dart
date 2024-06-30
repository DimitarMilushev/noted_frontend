import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';

part 'note-view.data.freezed.dart';

@freezed
class NoteViewData with _$NoteViewData {
  factory NoteViewData({
    NotePreviewCardData? data,
    @Default(false) bool? isSaving,
  }) = _NoteViewData;
}
