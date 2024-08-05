import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/note.view-model.dart';
import 'package:noted_frontend/src/shared/components/loader-screen.component.dart';
import 'package:noted_frontend/src/shared/components/popup-menu-icon-option.component.dart';

class NoteView extends ConsumerStatefulWidget {
  static const String route = '/note/:noteId';
  final num noteId;
  const NoteView(this.noteId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteViewState();
}

class _NoteViewState extends ConsumerState<NoteView> {
  final TextEditingController titleController = TextEditingController();
  final HtmlEditorController bodyController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(noteViewModelProvider(widget.noteId));
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
              loading: LoaderScreen.transparent,
            ),
          ),
        ),
      ],
    ));
  }

  Widget _onData(NoteViewData data) {
    if (titleController.text.isEmpty) {
      titleController.text = data.noteData.title;
    }

    return Column(
      children: [
        Align(
          child: _NoteViewPopupMenu(
            data.noteData.id,
            titleController,
            bodyController,
            data.isSaving,
          ),
          alignment: Alignment.topRight,
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: TextFormField(
              controller: titleController,
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
            initialText: data.noteData.content,
            darkMode:
                Theme.of(context).colorScheme.brightness == Brightness.dark,
          ),
        ),
      ],
    );
  }
}

class _NoteViewPopupMenu extends ConsumerWidget {
  final num id;
  final TextEditingController titleController;
  final HtmlEditorController bodyController;
  final bool isSaving;

  const _NoteViewPopupMenu(
      this.id, this.titleController, this.bodyController, this.isSaving,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: ref
                      .read(noteViewModelProvider.call(id).notifier)
                      .onDeletePressed,
                  child: const PopupMenuIconOption(
                    label: "Delete",
                    icon: Icons.delete,
                  )),
              PopupMenuItem(
                  enabled: !isSaving,
                  onTap: () async {
                    final bodyText = await bodyController.getText();
                    await ref
                        .read(noteViewModelProvider.call(id).notifier)
                        .onSavePressed(titleController.value.text, bodyText);
                  },
                  child: PopupMenuIconOption(
                    label: "Save",
                    icon: Icons.save,
                  )),
            ]);
  }
}


// class _NoteToolbar extends StatelessWidget {
//   final bool isSaving;
//   final Function() onSavePressed;
//   const _NoteToolbar(
//       {super.key, required this.isSaving, required this.onSavePressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Container(
//         height: 32,
//         alignment: AlignmentDirectional.centerEnd,
//         child: isSaving
//             ? const CircularProgressIndicator()
//             : GestureDetector(
//                 onTap: onSavePressed,
//                 child: const Icon(
//                   Icons.edit_document,
//                   size: 32,
//                 ),
//               ),
//       ),
//     );
//   }
// }
