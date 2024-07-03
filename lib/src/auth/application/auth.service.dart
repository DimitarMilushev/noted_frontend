import 'package:noted_frontend/src/auth/data/auth.repository.dart';
import 'package:noted_frontend/src/auth/data/models/user-role.enum.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth.service.g.dart";

@Riverpod()
AuthService authService(AuthServiceRef ref) => AuthService(
      repository: ref.read(authRepositoryProvider),
      session: ref.read(sessionProvider.notifier),
    );

class AuthService {
  final AuthRepository _repository;
  final Session _session;

  AuthService({
    required AuthRepository repository,
    required Session session,
  })  : _repository = repository,
        _session = session;

  Future<void> signIn(String email, String password) async {
    // final response = await _repository.signIn(email, password);
    // _session.startSession(response.email, response.username, response.role);
    _session.startSession(email, email, UserRole.admin);
  }

  Future<void> signOut() async {
    // await _repository.signOut();
    _session.endSession();
  }

  Future<void> signUp(String email, String username, String password) async {
    await _repository.signUp(
      email: email,
      username: username,
      password: password,
    );
  }

  sendRecoveryEmail(String email) {
    throw UnimplementedError();
  }
}
