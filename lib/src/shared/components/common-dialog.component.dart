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
    return Stack(children: [
      GestureDetector(onTap: context.pop),
      Center(
        child: Container(
            padding: EdgeInsets.all(32),
            constraints: BoxConstraints.loose(Size(560, 480)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: kElevationToShadow[2],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header != null
                    ? Text(header!,
                        style: Theme.of(context).textTheme.headlineMedium)
                    : SizedBox(),
                Expanded(child: body),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    secondaryAction != null
                        ? ElevatedButton(
                            onPressed: secondaryAction!.onTap,
                            child: Text(secondaryAction!.text))
                        : SizedBox(),
                    primaryAction != null
                        ? ElevatedButton(
                            onPressed: primaryAction!.onTap,
                            child: Text(primaryAction!.text))
                        : SizedBox(),
                  ],
                )
              ],
            )),
      )
    ]);
  }
}

class DialogActionData {
  final String text;
  final void Function() onTap;
  DialogActionData({required this.text, required this.onTap});
}
