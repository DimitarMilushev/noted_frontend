import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_frontend/src/auth/presentation/view-models/sign-up.view-model.dart';

class SignUpView extends ConsumerStatefulWidget {
  static const String route = "/sign-up";
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late final SignUpViewModel viewModel;
  @override
  void initState() {
    viewModel = ref.read(signUpViewModelProvider.notifier);
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
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "Sign Up!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  _UserDataForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    viewModel: viewModel,
                    usernameController: usernameController,
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

class _UserDataForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final SignUpViewModel viewModel;

  const _UserDataForm({
    required this.emailController,
    required this.passwordController,
    required this.viewModel,
    required this.usernameController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text("Email")),
            controller: emailController,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text("Username")),
            controller: usernameController,
          ),
          const SizedBox.square(
            dimension: 24,
          ),
          TextField(
            decoration: const InputDecoration(label: Text("Password")),
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: "*",
          ),
          TextField(
            decoration: const InputDecoration(label: Text("Confirm password")),
            controller: confirmPasswordController,
            obscureText: true,
            obscuringCharacter: "*",
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(32),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(128, 48)),
            onPressed: () => viewModel.signUp(
              emailController.value.text,
              usernameController.value.text,
              passwordController.value.text,
            ),
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
