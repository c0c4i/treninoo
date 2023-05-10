import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treninoo/app.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/utils.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await sharedPrefs.init();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Make status bar and navigation look beautiful
  Utils.setAppBarBrightness(savedThemeMode != null && savedThemeMode.isDark);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  runApp(App(savedThemeMode: savedThemeMode));
}
