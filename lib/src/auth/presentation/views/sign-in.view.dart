import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/presentation/view-models/sign-in.view-model.dart';
import 'package:noted_frontend/src/dashboard/presentation/dashboard.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';

class SignInView extends ConsumerStatefulWidget {
  static const String route = "/sign-in";
  const SignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final SignInViewModel viewModel;
  @override
  void initState() {
    viewModel = ref.read(signInViewModelProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            constraints: const BoxConstraints(maxWidth: 366),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 64),
                  child: Text("My Local Band",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Form(
                  child: Column(
                    children: [
                      TextField(
                          decoration:
                              const InputDecoration(label: Text("Email")),
                          controller: emailController),
                      TextField(
                        decoration:
                            const InputDecoration(label: Text("Password")),
                        controller: passwordController,
                        obscureText: true,
                        obscuringCharacter: "*",
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                throw UnimplementedError();
                              },
                              child: const Text("Forgotten password?"))),
                      SizedBox.fromSize(
                        size: const Size.fromHeight(32),
                      ),
                      ElevatedButton(
                        onPressed: () => viewModel.signIn(
                          emailController.value.text,
                          passwordController.value.text,
                        ),
                        child: const Text("Sign In"),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

}
