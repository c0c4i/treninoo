import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/view/components/dialog/train_not_found.dart';

import '../../../bloc/exist/exist.dart';
import '../../../bloc/favourites/favourites.dart';
import '../../../bloc/recents/recents.dart';
import '../../../enum/saved_train_type.dart';
import '../../../model/SavedTrain.dart';
import '../../../model/Station.dart';
import '../../router/routes_names.dart';
import '../dialog/departure_stations_dialog.dart';
import '../loading_dialog.dart';

class HandleExistBloc extends StatelessWidget {
  const HandleExistBloc({
    Key? key,
    required this.child,
    this.showRemove,
  }) : super(key: key);

  final Widget child;
  final bool? showRemove;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExistBloc, ExistState>(
      listener: (context, state) async {
        if (state is ExistSuccess) {
          LoadingDialog.hide(context);
          SavedTrain savedTrain = SavedTrain.fromTrainInfo(state.trainInfo);
          context.read<RecentsBloc>().add(RecentsRequest());
          Navigator.pushNamed(
            context,
            RoutesNames.status,
            arguments: savedTrain,
          );
          return;
        }

        if (state is ExistMoreThanOne) {
          LoadingDialog.hide(context);
          Station? departureStation = await DepartureStationsDialog.show(
            context,
            departureStations: state.stations,
          );
          if (departureStation == null) return;
          SavedTrain savedTrain = SavedTrain.fromDepartureStation(
            state.savedTrain,
            departureStation,
          );
          context.read<ExistBloc>().add(
                ExistRequest(savedTrain: savedTrain),
              );
        }

        if (state is ExistFailed) {
          LoadingDialog.hide(context);
          bool remove = await TrainNotFoundDialog.show(
            context,
            savedTrain: state.savedTrain,
            savedTrainType: state.type,
          );
          if (remove == true) {
            await Future.delayed(Duration(milliseconds: 500));

            state.type == SavedTrainType.recents
                ? context
                    .read<RecentsBloc>()
                    .add(DeleteRecent(savedTrain: state.savedTrain))
                : context
                    .read<FavouritesBloc>()
                    .add(DeleteFavourite(savedTrain: state.savedTrain));
          }
        }

        if (state is ExistLoading) LoadingDialog.show(context);
      },
      child: child,
    );
  }
}
