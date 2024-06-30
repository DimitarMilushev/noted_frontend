import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/note.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';

class NotePreviewCard extends ConsumerWidget {
  final NotePreviewCardData data;
  const NotePreviewCard(this.data, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(routerProvider).go(NoteView.getRouteForId(data.id));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          border: Border.all(),
        ),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints.expand(width: 244, height: 244),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                "${data.title}\n", //Ensure always 2 lines of text
                softWrap: true,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(overflow: TextOverflow.ellipsis),
              ),
            ),
            const Divider(),
            SizedBox.fromSize(size: const Size.fromHeight(20)),
            Expanded(
              child: Text(
                data.text,
                softWrap: true,
                maxLines: 4,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Text(data.lastUpdated.toString()),
            )
          ],
        ),
      ),
    );
  }
}

class NotePreviewCardData {
  final num id;
  final String text;
  final String title;
  final DateTime lastUpdated;

  NotePreviewCardData({
    required this.id,
    required this.text,
    required this.title,
    required this.lastUpdated,
  });
}
