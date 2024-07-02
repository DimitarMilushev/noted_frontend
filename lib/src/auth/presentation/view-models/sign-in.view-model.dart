import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/auth/presentation/views/forgotten-password.view.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-up.view.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign-in.view-model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  late final AuthService _service;
  @override
  FutureOr<void> build() {
    _service = ref.read(authServiceProvider);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.signIn(email, password));
    if (state.hasError) {
      print('Has Error!');
      print(state.error);
      return;
    }

    ref.read(routerProvider).go(DashboardView.route);
  }

  Future<void> onSignInWithGooglePressed() {
    throw UnimplementedError();
  }

  Future<void> onSignInWithGithubPressed() {
    throw UnimplementedError();
  }

  void forgottenPassword() {
    ref.read(routerProvider).go(ForgottenPasswordView.route);
  }

  void signUp() {
    ref.read(routerProvider).go(SignUpView.route);
  }
}
