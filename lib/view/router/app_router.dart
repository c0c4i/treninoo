import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/pages/solutions_result_page.dart';
import 'package:treninoo/view/pages/train_status_page.dart';
import 'package:treninoo/view/pages/home_page.dart';
import 'package:treninoo/view/router/routes_names.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    TrainRepository trainRepository = APITrain();

    switch (settings.name) {
      case RoutesNames.home:
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
              create: (context) => trainRepository,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        DepartureStationBloc(context.read<TrainRepository>()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        ExistBloc(context.read<TrainRepository>()),
                  ),
                ],
                child: HomePage(),
              )),
        );

      case RoutesNames.status:
        final savedTrain = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => trainRepository,
            child: BlocProvider(
              create: (context) =>
                  TrainStatusBloc(context.read<TrainRepository>()),
              child: TrainStatusPage(savedTrain: savedTrain),
            ),
          ),
        );
      case RoutesNames.solutions:
        final solutionsInfo = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => trainRepository,
            child: BlocProvider(
              create: (context) =>
                  SolutionsBloc(context.read<TrainRepository>()),
              child: SolutionsResultPage(solutionsInfo: solutionsInfo),
            ),
          ),
        );
      default:
        return null;
    }
  }
}
