import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteModalView extends ConsumerStatefulWidget {
  final String? noteId;
  const NoteModalView({
    super.key,
    required this.noteId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteModalViewState();
}

class _NoteModalViewState extends ConsumerState<NoteModalView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Text("Data for note ${widget.noteId}"),
    );
  }
}
