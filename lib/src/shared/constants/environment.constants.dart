import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConstants {
  static String appURI = dotenv.get(
    "APP_URI",
    fallback: "http://localhost:9000",
  );
}
