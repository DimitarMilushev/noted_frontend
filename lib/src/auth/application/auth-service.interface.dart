import 'package:noted_frontend/src/auth/data/models/authenticator.model.dart';

abstract class AuthenticatorService {
  final AuthenticatorModel _data;

  AuthenticatorService(AuthenticatorModel data) : _data = data;

  /// Sends an access request to the authorization server and returns the
  /// access token.
  Future requestToken(String username, String password);

  /// Sends a revoke request to remove the session in the authorization server.
  Future revokeAccess();
}
