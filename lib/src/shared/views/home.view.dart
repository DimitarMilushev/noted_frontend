import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String route = "/";
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber,child: Center(child: ElevatedButton(child: Text("go to sign in"), onPressed: () {
      this.ref.read(routerProvider).go(SignInView.route);
    },),),);
  }
}