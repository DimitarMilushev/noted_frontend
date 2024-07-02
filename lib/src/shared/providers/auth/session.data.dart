import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/auth/data/models/user-role.enum.dart';

part 'session.data.freezed.dart';

@freezed
class SessionData with _$SessionData {
  factory SessionData({
    required String username,
    required String email,
    required UserRole role,
  }) = _SessionData;
}
