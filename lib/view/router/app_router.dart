import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/main.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/pages/home_page.dart';
import 'package:treninoo/view/pages/search_train_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    TrainRepository trainRepository = APITrain();

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => RepositoryProvider<TrainRepository>(
            create: (context) => trainRepository,
            child: BlocProvider(
              create: (context) =>
                  DepartureStationBloc(context.read<TrainRepository>()),
              child: HomePage(),
            ),
          ),
        );

      case '/status':
        return null;
      case '/solutions':
        return null;
      default:
        return null;
    }
  }
}
