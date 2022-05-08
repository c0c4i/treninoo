/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/router/app_router.dart';
import 'package:treninoo/view/style/theme.dart';

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

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final AdaptiveThemeMode savedThemeMode;

  MyApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Treninoo',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('it'), const Locale('en')],
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
