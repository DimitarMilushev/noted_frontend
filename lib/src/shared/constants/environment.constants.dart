import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConstants {
  static String appURI = dotenv.get(
    "APP_URI",
    fallback: "http://localhost:9000",
  );

  static String githubClientId = dotenv.get("GITHUB_CLIENT_ID");
  static String githubSecret = dotenv.get("GITHUB_SECRET");
  static List<String> githubScopes = dotenv.get("GITHUB_SCOPES").split(", ");
  static String githubAuthEndpoint = dotenv.get("GITHUB_AUTH_ENDPOINT");
  static String githubTokenEndpoint = dotenv.get("GITHUB_TOKEN_ENDPOINT");
}
