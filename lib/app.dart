import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:treninoo/view/router/app_router.dart';
import 'package:treninoo/view/style/theme.dart';

import 'bloc/exist/exist.dart';
import 'bloc/recents/recents.dart';
import 'repository/train.dart';

class App extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final AdaptiveThemeMode savedThemeMode;

  App({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => RepositoryProvider<TrainRepository>(
        create: (context) => APITrain(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RecentsBloc(
                context.read<TrainRepository>(),
              )..add(RecentsRequest()),
            ),
            BlocProvider(
              create: (context) => ExistBloc(
                context.read<TrainRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Treninoo',
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: [const Locale('it'), const Locale('en')],
            onGenerateRoute: _appRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
