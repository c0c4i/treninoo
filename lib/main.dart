import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/app.dart';
import 'package:treninoo/repository/saved_solution.dart';
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

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Make status bar and navigation look beautiful
  Utils.setAppBarBrightness(savedThemeMode != null && savedThemeMode.isDark);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  SharedPrefs sharedPrefs = SharedPrefs();
  await sharedPrefs.setup();

  TrainRepository trainRepository = APITrain();
  SavedTrainRepository savedTrainRepository = APISavedTrain(sharedPrefs);
  SavedStationsRepository savedStationRepository = APISavedStation(sharedPrefs);
  SavedSolutionInfoRepository savedSolutionInfoRepository =
      APISavedSolution(sharedPrefs);

  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode
          ? ''
          : 'https://c2d5e0ab99c7a5e0b91699645bc5bbb2@o4506203971846144.ingest.sentry.io/4506203973615616';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      App(
        savedThemeMode: savedThemeMode,
        trainRepository: trainRepository,
        savedTrainRepository: savedTrainRepository,
        savedStationsRepository: savedStationRepository,
        savedSolutionInfoRepository: savedSolutionInfoRepository,
      ),
    ),
  );
}
