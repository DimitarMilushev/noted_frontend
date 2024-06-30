import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.data.freezed.dart';

@freezed
class SessionData with _$SessionData {
  factory SessionData({
    String? session,
    String? username,
    String? email,
  }) = _SessionData;
}
