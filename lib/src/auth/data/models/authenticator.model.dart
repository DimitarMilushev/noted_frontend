import 'package:freezed_annotation/freezed_annotation.dart';

part 'authenticator.model.freezed.dart';

@freezed
class AuthenticatorModel with _$AuthenticatorModel {
  const factory AuthenticatorModel({
    required String clientId,
    required String clientSecret,
    required List<String> scopes,
    required Uri authEndpoint,
    required Uri tokenEndpoint,
    Uri? redirectUri,
  }) = _AuthenticatorModel;
}
