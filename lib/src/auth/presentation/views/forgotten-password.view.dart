import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/presentation/view-models/forgotten-password.view-model.dart';

class ForgottenPasswordView extends ConsumerStatefulWidget {
  static const String route = "/forgotten-password";
  const ForgottenPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgottenPasswordViewState();
}

class _ForgottenPasswordViewState extends ConsumerState<ForgottenPasswordView> {
  final TextEditingController emailController = TextEditingController();
  late final ForgottenPasswordViewModel viewModel;
  @override
  void initState() {
    viewModel = ref.read(forgottenPasswordViewModelProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFEAC5E),
                  Color(0xFFC779D0),
                  Color(0xFF4BC0C8),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              constraints: BoxConstraints.loose(const Size(368, 468)),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
                boxShadow: kElevationToShadow[1],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "Forgotten password",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("Enter your email")),
                    controller: emailController,
                    obscureText: true,
                    obscuringCharacter: "*",
                  ),
                  SizedBox.fromSize(
                    size: const Size.fromHeight(32),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(128, 48)),
                    onPressed: () => viewModel.recoverAccount(
                      emailController.value.text,
                    ),
                    child: const Text("Send recovery email"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
