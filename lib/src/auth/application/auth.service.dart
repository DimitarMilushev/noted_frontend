import 'package:noted_frontend/src/auth/data/auth.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth.service.g.dart";

@Riverpod()
AuthService authService(AuthServiceRef ref) => AuthService(
      repository: ref.read(authRepositoryProvider),
      // session: ref.read(sessionProvider.notifier)
    );

class AuthService {
  final AuthRepository repository;
  // final Session session;
  AuthService({required this.repository});

  Future<void> signIn(String email, String password) async {
    await repository.signIn(email, password);
    // await session.begin(sessionData);
  }

  Future<void> signOut() async {
    await repository.signOut();
    // await session.end();
  }

  Future<void> signUp(String email, String username, String password) async {
    await repository.signUp(
      email: email,
      username: username,
      password: password,
    );
  }

  sendRecoveryEmail(String email) {
    throw UnimplementedError();
  }
}
