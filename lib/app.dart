import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:treninoo/cubit/predicted_arrival.dart';
import 'package:treninoo/view/router/app_router.dart';
import 'package:treninoo/view/style/theme.dart';

import 'bloc/exist/exist.dart';
import 'bloc/favourites/favourites.dart';
import 'bloc/recents/recents.dart';
import 'cubit/first_page.dart';
import 'repository/saved_train.dart';
import 'repository/train.dart';

class App extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final AdaptiveThemeMode? savedThemeMode;
  final TrainRepository trainRepository;
  final SavedTrainRepository savedTrainRepository;

  App({
    Key? key,
    this.savedThemeMode,
    required this.trainRepository,
    required this.savedTrainRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => trainRepository,
          ),
          RepositoryProvider(
            create: (context) => savedTrainRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RecentsBloc(
                context.read<SavedTrainRepository>(),
              )..add(RecentsRequest()),
            ),
            BlocProvider(
              create: (context) => ExistBloc(
                context.read<TrainRepository>(),
                context.read<SavedTrainRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  FavouritesBloc(context.read<SavedTrainRepository>())
                    ..add(FavouritesRequest()),
            ),
            BlocProvider(
              create: (_) => FirstPageCubit(savedTrainRepository),
            ),
            BlocProvider(
              create: (_) => PredictedArrivalCubit(savedTrainRepository),
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
