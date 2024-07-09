import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl_browser.dart';

import 'src/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  //TODO: Create other configs!! THIS WILL FAIL ON MOBILE
  await findSystemLocale();
  runApp(const ProviderScope(child: MyApp()));
}
