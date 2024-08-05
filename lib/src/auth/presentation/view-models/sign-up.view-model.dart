import 'dart:convert';

import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign-up.view-model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  late final AuthService _service;
  @override
  FutureOr<void> build() {
    _service = ref.read(authServiceProvider);
  }

  Future<void> signUp(String email, String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _service.signUp(email, username, password),
    );
    if (state.hasError) {
      print('Has Error!');
      print(state.error);
      return;
    }

    final encodedEmail = const Base64Codec().encode(email.codeUnits);
    final encodedPassword = const Base64Codec().encode(password.codeUnits);
    ref.read(routerProvider).go(
          "${SignInView.route}?email=$encodedEmail&password=$encodedPassword",
        );
  }

  Future<void> onSignUpWithGooglePressed() {
    throw UnimplementedError();
  }

  Future<void> onSignUpWithGithubPressed() {
    throw UnimplementedError();
  }
}
