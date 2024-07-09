import 'package:noted_frontend/src/auth/data/models/user-role.enum.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.provider.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  FutureOr<SessionData?> build() {
    //TODO: Check store
    return null;
  }

  bool get isLoggedIn => state.unwrapPrevious().valueOrNull != null;
  // bool get isLoggedIn => true;

  void startSession(String email, String username, UserRole role) {
    final session = SessionData(
      username: username,
      email: email,
      role: role,
    );
    state = AsyncData(session);
  }

  void endSession() {
    state = const AsyncData(null);
  }
}
