import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noted_frontend/src/auth/data/models/user-role.enum.dart';

part 'sign-in.response.freezed.dart';
part 'sign-in.response.g.dart';

@freezed
class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    required String email,
    required String username,
    required UserRole role,
  }) = _SignInResponse;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);
}
