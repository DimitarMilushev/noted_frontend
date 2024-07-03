import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeletedView extends ConsumerStatefulWidget {
  static const String route = '/deleted';
  const DeletedView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeletedViewState();
}

class _DeletedViewState extends ConsumerState<DeletedView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
