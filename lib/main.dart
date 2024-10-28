import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treninoo/app.dart';
import 'package:treninoo/repository/saved_station.dart';
import 'package:treninoo/repository/saved_train.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/utils.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'repository/train.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Make status bar and navigation look beautiful
  Utils.setAppBarBrightness(savedThemeMode != null && savedThemeMode.isDark);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  SharedPrefs sharedPrefs = SharedPrefs();
  await sharedPrefs.setup();

  TrainRepository trainRepository = APITrain();
  SavedTrainRepository savedTrainRepository = APISavedTrain(sharedPrefs);
  SavedStationsRepository savedStationRepository = APISavedStation(sharedPrefs);

  runApp(
    App(
      savedThemeMode: savedThemeMode,
      trainRepository: trainRepository,
      savedTrainRepository: savedTrainRepository,
      savedStationsRepository: savedStationRepository,
    ),
  );
}
