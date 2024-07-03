import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StarredView extends ConsumerStatefulWidget {
  static const String route = '/starred';
  const StarredView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StarredViewState();
}

class _StarredViewState extends ConsumerState<StarredView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
