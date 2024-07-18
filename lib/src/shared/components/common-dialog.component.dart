import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonDialogComponent extends StatelessWidget {
  final String? header;
  final Widget body;
  final DialogActionData? primaryAction;
  final DialogActionData? secondaryAction;
  const CommonDialogComponent({
    super.key,
    this.header,
    required this.body,
    this.primaryAction,
    this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final viewSpace = MediaQuery.sizeOf(context);

    return Stack(alignment: Alignment.center, children: [
      GestureDetector(onTap: context.pop),
      Container(
          padding: const EdgeInsets.all(32),
          constraints: BoxConstraints(
            maxWidth: viewSpace.width * 0.8,
            maxHeight: viewSpace.height * 0.8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Theme.of(context).colorScheme.primaryContainer,
            boxShadow: kElevationToShadow[2],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (header != null)
                Text(
                  header!,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                constraints: const BoxConstraints(
                  minWidth: 360,
                  minHeight: 240,
                ),
                child: body,
              ),
              if (secondaryAction != null || primaryAction != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _OptionalDialogActionButton(data: secondaryAction),
                    _OptionalDialogActionButton(data: primaryAction),
                  ],
                )
            ],
          )),
    ]);
  }
}

class _OptionalDialogActionButton extends StatelessWidget {
  final DialogActionData? data;
  const _OptionalDialogActionButton({this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox();

    return ElevatedButton(
      onPressed: data!.isEnabled ? data!.onTap : null,
      child: Text(data!.text),
    );
  }
}

class DialogActionData {
  final String text;
  final void Function() onTap;
  final bool isEnabled;

  DialogActionData({
    required this.text,
    required this.onTap,
    this.isEnabled = true,
  });
}
