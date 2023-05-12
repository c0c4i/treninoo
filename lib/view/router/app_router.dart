import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/bloc/followtrain_stations/followtrain_stations_bloc.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/saved_train.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/pages/edit_description_page.dart';
import 'package:treninoo/view/pages/follow_train_page.dart';
import 'package:treninoo/view/pages/solutions_result_page.dart';
import 'package:treninoo/view/pages/station_status_page.dart';
import 'package:treninoo/view/pages/train_status_page.dart';
import 'package:treninoo/view/pages/home_page.dart';
import 'package:treninoo/view/router/routes_names.dart';

import '../../bloc/edit_description/edit_description_bloc.dart';
import '../../bloc/favourite/favourite_bloc.dart';
import '../../bloc/send_feedback/send_feedback.dart';
import '../pages/send_feedback_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.home:
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
              create: (context) => context.read<TrainRepository>(),
              child: BlocProvider(
                create: (context) => DepartureStationBloc(
                  context.read<TrainRepository>(),
                ),
                child: HomePage(),
              )),
        );

      case RoutesNames.status:
        final savedTrain = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => TrainStatusBloc(
                    context.read<TrainRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FavouriteBloc(
                    context.read<SavedTrainRepository>(),
                  ),
                ),
              ],
              child: TrainStatusPage(savedTrain: savedTrain),
            ),
          ),
        );
      case RoutesNames.solutions:
        final solutionsInfo = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: BlocProvider(
              create: (context) => SolutionsBloc(
                context.read<TrainRepository>(),
                context.read<SavedTrainRepository>(),
              ),
              child: SolutionsResultPage(solutionsInfo: solutionsInfo),
            ),
          ),
        );
      case RoutesNames.station:
        Station station = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => StationStatusBloc(
                    context.read<TrainRepository>(),
                    context.read<SavedTrainRepository>(),
                  )..add(StationStatusRequest(station: station)),
                ),
              ],
              child: StationStatusPage(station: station),
            ),
          ),
        );

      case RoutesNames.followTrainStations:
        final departureStation = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: BlocProvider(
              create: (context) => FollowTrainStationsBloc(
                context.read<TrainRepository>(),
              ),
              child: FollowTrainPage(departureStation: departureStation),
            ),
          ),
        );

      case RoutesNames.editDescription:
        final description = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: BlocProvider(
              create: (context) => EditDescriptionBloc(
                context.read<SavedTrainRepository>(),
              ),
              child: EditDescriptionPage(savedTrain: description),
            ),
          ),
        );

      case RoutesNames.sendFeedback:
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => context.read<TrainRepository>(),
            child: BlocProvider(
              create: (context) => SendFeedbackBloc(
                context.read<TrainRepository>(),
              ),
              child: SendFeedbackPage(),
            ),
          ),
        );

      default:
        return null;
    }
  }
}
