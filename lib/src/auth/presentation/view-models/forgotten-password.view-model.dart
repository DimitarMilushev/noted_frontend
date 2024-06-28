import 'package:noted_frontend/src/auth/application/auth.service.dart';
import 'package:noted_frontend/src/auth/presentation/views/sign-in.view.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgotten-password.view-model.g.dart';

@riverpod
class ForgottenPasswordViewModel extends _$ForgottenPasswordViewModel {
  late final AuthService _service;
  @override
  FutureOr<void> build() {
    _service = ref.read(authServiceProvider);
  }

  Future<void> recoverAccount(String email) async {
    await _service.sendRecoveryEmail(email);

    ref.read(routerProvider).go(SignInView.route);
  }
}
