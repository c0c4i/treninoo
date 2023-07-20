import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/app.dart';
import 'package:treninoo/repository/saved_train.dart';
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

  TrainRepository trainRepository = APITrain();
  SavedTrainRepository savedTrainRepository = APISavedTrain();
  await savedTrainRepository.setup();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://b5d7e7baa42a47c68bda155d1c27539d@sentry.hyperbit.it/3';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      App(
        savedThemeMode: savedThemeMode,
        trainRepository: trainRepository,
        savedTrainRepository: savedTrainRepository,
      ),
    ),
  );
}
