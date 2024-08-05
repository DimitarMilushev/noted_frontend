import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  final Color? background;
  final bool hasBackground;
  const LoaderScreen({
    super.key,
    this.background,
    required this.hasBackground,
  });

  static LoaderScreen transparent() => const LoaderScreen(hasBackground: false);
  static LoaderScreen dimmed() => LoaderScreen(
        hasBackground: true,
        background: Colors.black.withOpacity(0.3),
      );

  @override
  Widget build(BuildContext context) {
    if (!hasBackground) return const _SmallLoader();

    return DecoratedBox(
      decoration: BoxDecoration(color: background),
      child: const _SmallLoader(),
    );
  }
}

class _SmallLoader extends StatelessWidget {
  const _SmallLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
