import 'package:noted_frontend/src/shared/providers/auth/session.data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.provider.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  FutureOr<SessionData> build() {
    //TODO: Check store
    return SessionData();
  }

  bool get isLoggedIn => state.value?.session != null;

  void startSession(String session, String username, String email) {
    state = AsyncData(
        SessionData(email: email, username: username, session: session));
  }

  void endSession(String session, String username, String email) {
    state = AsyncData(SessionData());
  }
}
