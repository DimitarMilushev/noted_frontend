import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:noted_frontend/src/auth/presentation/view-models/sign-in.view-model.dart';

class SignInView extends ConsumerStatefulWidget {
  static const String route = "/sign-in";
  final String? email;
  final String? password;
  const SignInView({
    super.key,
    this.email,
    this.password,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  late final TextEditingController emailController, passwordController;
  late final SignInViewModel viewModel;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    viewModel = ref.read(signInViewModelProvider.notifier);
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
                  Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterSocialButton(
                          mini: true,
                          buttonType: ButtonType.github,
                          onTap: viewModel.onSignInWithGithubPressed,
                        ),
                        FlutterSocialButton(
                          mini: true,
                          buttonType: ButtonType.google,
                          onTap: viewModel.onSignInWithGooglePressed,
                        ),
                      ],
                    ),
                  ),
                  _UsernamePasswordForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      viewModel: viewModel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsernamePasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final SignInViewModel viewModel;

  const _UsernamePasswordForm({
    required this.emailController,
    required this.passwordController,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(label: Text("Email")),
              controller: emailController),
          TextField(
            decoration: const InputDecoration(label: Text("Password")),
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: "*",
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: viewModel.forgottenPassword,
              child: const Text("Forgotten password"),
            ),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(32),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(128, 48)),
            onPressed: () => viewModel.signIn(
              emailController.value.text,
              passwordController.value.text,
            ),
            child: const Text("Login"),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(12),
          ),
          OutlinedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(128, 48)),
            onPressed: viewModel.signUp,
            child: const Text("Register"),
          )
        ],
      ),
    );
  }
}
