import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/dashboard/presentation/models/note.model.dart';

part 'notebook.model.freezed.dart';

@freezed
class Notebook with _$Notebook {
  factory Notebook({
    required num id,
    required String title,
    required DateTime lastUpdated,
    List<NoteRef>? notes,
  }) = _Notebook;
}
