import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardSupportSection extends ConsumerWidget {
  const DashboardSupportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = _getCards(ref);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Support us",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Divider(),
                  ])),
          SizedBox.fromSize(
              size: Size.fromHeight(512),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => cards[index],
                separatorBuilder: (_, __) => SizedBox.fromSize(
                  size: Size.fromWidth(24),
                ),
                itemCount: cards.length,
              )),
        ],
      ),
    );
  }

  List<Widget> _getCards(WidgetRef ref) {
    return [
      SizedBox.fromSize(
          size: const Size.square(512),
          child: _LargeDecoratedCard(
              onPressed: () => launchUrl(
                  Uri.parse(
                    "https://github.com/DimitarMilushev/noted_frontend",
                  ),
                  webOnlyWindowName: "_blank"),
              backgroundImage: const NetworkImage(
                  'https://miro.medium.com/v2/resize:fit:600/1*lU3VPHLtkyu4SUaVx6lemA.png'),
              icon: Image.network(
                  color: Colors.white,
                  'https://static.thenounproject.com/png/1694652-200.png'),
              text:
                  "This project is open-source. Feel free to open issues and further contribute!")),
      SizedBox.fromSize(
          size: const Size.square(512),
          child: _LargeDecoratedCard(
              onPressed: () =>
                  ref.read(routerProvider).go("/support/buy-me-a-coffee"),
              backgroundImage: const NetworkImage(
                  'https://thumbs.dreamstime.com/b/cup-pixel-coffee-pixelate-coffee-digital-coffee-pixel-art-coffee-cup-58516753.jpg'),
              icon: Image.network(
                  'https://cdn.pixabay.com/photo/2017/09/23/16/33/pixel-heart-2779422_1280.png'),
              text: "Buy me a coffee"))
    ];
  }
}

class _LargeDecoratedCard extends StatelessWidget {
  final Widget? icon;
  final String text;
  final void Function()? onPressed;
  final ImageProvider<Object> backgroundImage;
  const _LargeDecoratedCard({
    super.key,
    this.onPressed,
    required this.backgroundImage,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: backgroundImage),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (icon != null) ...[
                      SizedBox.fromSize(
                        size: const Size.square(40),
                        child: icon,
                      ),
                      SizedBox.fromSize(size: const Size.fromHeight(48)),
                    ],
                    Text(
                      text,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                shadows: kElevationToShadow[1],
                              ),
                    )
                  ]),
            )),
      ),
    );
  }
}
