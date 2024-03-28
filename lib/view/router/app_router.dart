import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/followtrain_stations/followtrain_stations_bloc.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/saved_station.dart';
import 'package:treninoo/repository/saved_train.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/pages/edit_description_page.dart';
import 'package:treninoo/view/pages/follow_train_page.dart';
import 'package:treninoo/view/pages/reorder_favourites_page.dart';
import 'package:treninoo/view/pages/solutions_result_page.dart';
import 'package:treninoo/view/pages/station_status_page.dart';
import 'package:treninoo/view/pages/train_status_page.dart';
import 'package:treninoo/view/pages/home_page.dart';
import 'package:treninoo/view/router/routes_names.dart';

import '../../bloc/edit_description/edit_description_bloc.dart';
import '../../bloc/favourite/favourite_bloc.dart';
import '../../bloc/send_feedback/send_feedback.dart';
import '../../model/SolutionsInfo.dart';
import '../pages/send_feedback_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.home:
        return CupertinoPageRoute(
          builder: (_) => HomePage(),
        );

      case RoutesNames.status:
        final savedTrain = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
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
            child: TrainStatusPage(savedTrain: savedTrain as SavedTrain),
          ),
        );
      case RoutesNames.solutions:
        final solutionsInfo = settings.arguments as SolutionsInfo;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SolutionsBloc(
              context.read<TrainRepository>(),
              context.read<SavedStationsRepository>(),
            ),
            child: SolutionsResultPage(solutionsInfo: solutionsInfo),
          ),
        );
      case RoutesNames.station:
        Station station = settings.arguments as Station;
        return CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => StationStatusBloc(
                  context.read<TrainRepository>(),
                  context.read<SavedStationsRepository>(),
                )..add(StationStatusRequest(station: station)),
              ),
            ],
            child: StationStatusPage(station: station),
          ),
        );

      case RoutesNames.followTrainStations:
        final savedTrain = settings.arguments as SavedTrain;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FollowTrainStationsBloc(
              context.read<TrainRepository>(),
            ),
            child: FollowTrainPage(savedTrain: savedTrain),
          ),
        );

      case RoutesNames.editDescription:
        final description = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditDescriptionBloc(
              context.read<SavedTrainRepository>(),
            ),
            child: EditDescriptionPage(savedTrain: description as SavedTrain?),
          ),
        );

      case RoutesNames.sendFeedback:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SendFeedbackBloc(
              context.read<TrainRepository>(),
            ),
            child: SendFeedbackPage(),
          ),
        );

      case RoutesNames.reorderFavourites:
        return CupertinoPageRoute(
          builder: (_) => ReorderFavouritesPage(),
        );

      default:
        return null;
    }
  }
}
