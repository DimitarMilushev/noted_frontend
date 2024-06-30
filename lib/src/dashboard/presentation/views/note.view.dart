import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/note-view.data.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/note.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';

class NoteView extends ConsumerStatefulWidget {
  static const String route = '/note/:noteId';
  static String getRouteForId(num id) =>
      '${DashboardView.route}/note/${id.toString()}';
  final num noteId;
  const NoteView(this.noteId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteViewState();
}

class _NoteViewState extends ConsumerState<NoteView> {
  late final NoteViewModel viewModel;
  final HtmlEditorController bodyController = HtmlEditorController();

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(noteViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(viewModel.loadData(widget.noteId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(noteViewModelProvider);
    return SafeArea(
        child: Stack(
      children: [
        const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black12),
          ),
        ),
        Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  vertical: BorderSide(
                      style: BorderStyle.solid,
                      color: Color.fromARGB(71, 0, 0, 0))),
            ),
            constraints: BoxConstraints(maxWidth: 1024),
            child: viewState.when(
                data: (data) => _onData(data),
                error: (_, __) => Container(),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ),
        ),
      ],
    ));
  }

  Widget _onData(NoteViewData data) => Column(
        children: [
          _NoteToolbar(
            onSavePressed: viewModel.saveChanges,
            isSaving: viewModel.isSaving,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextFormField(
                initialValue: data.data?.title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          const SizedBox(height: 24),
          HtmlEditor(
            controller: bodyController, //required
            htmlEditorOptions: HtmlEditorOptions(
              autoAdjustHeight: true,
              initialText: data.data?.text,
              darkMode:
                  Theme.of(context).colorScheme.brightness == Brightness.dark,
            ),
          ),
        ],
      );
}

class _NoteToolbar extends StatelessWidget {
  final bool isSaving;
  final Function() onSavePressed;
  const _NoteToolbar(
      {super.key, required this.isSaving, required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        height: 32,
        alignment: AlignmentDirectional.centerEnd,
        child: isSaving
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: onSavePressed,
                child: const Icon(
                  Icons.edit_document,
                  size: 32,
                ),
              ),
      ),
    );
  }
}
