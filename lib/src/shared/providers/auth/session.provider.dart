import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noted_frontend/src/auth/data/models/user-role.enum.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.provider.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  static const String _sessionPath = 'noted_user_session';
  late final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  FutureOr<SessionData?> build() async {
    final dynamic recovered = await _storage.read(key: _sessionPath);
    if (recovered == null) return null;
    SessionData? session;
    try {
      session = SessionData.fromJson(jsonDecode(recovered));
      // ignore: unused_catch_stack
    } catch (e, st) {
      // TODO - logging
      await _storage.delete(key: _sessionPath);
    }
    return session;
  }

  bool get isLoggedIn => state.unwrapPrevious().valueOrNull != null;

  Future<void> startSession(
    String email,
    String username,
    UserRole role,
  ) async {
    state = const AsyncLoading();
    final session = SessionData(
      username: username,
      email: email,
      role: role,
    );
    await _storage.write(
      key: _sessionPath,
      value: jsonEncode(session.toJson()),
    );

    state = AsyncData(session);
  }

  Future<void> endSession() async {
    state = const AsyncLoading();
    await _storage.delete(key: _sessionPath);
    state = const AsyncData(null);
  }
}
