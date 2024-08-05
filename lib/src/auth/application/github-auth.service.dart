import 'package:noted_frontend/src/auth/application/auth-service.interface.dart';
import 'package:noted_frontend/src/auth/data/models/authenticator.model.dart';
import 'package:noted_frontend/src/shared/constants/environment.constants.dart';

class GithubService extends AuthenticatorService {
  GithubService()
      : super(AuthenticatorModel(
          clientId: EnvironmentConstants.githubClientId,
          clientSecret: EnvironmentConstants.githubSecret,
          scopes: EnvironmentConstants.githubScopes,
          authEndpoint: Uri.parse(EnvironmentConstants.githubAuthEndpoint),
          tokenEndpoint: Uri.parse(EnvironmentConstants.githubTokenEndpoint),
        ));

  @override
  Future requestToken(String username, String password) {
    // TODO: implement requestToken
    throw UnimplementedError();
  }

  @override
  Future revokeAccess() {
    // TODO: implement revokeAccess
    throw UnimplementedError();
  }
}
