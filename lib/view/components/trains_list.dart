import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/dialog/remove_train_dialog.dart';
import 'package:treninoo/view/components/loading_dialog.dart';
import 'package:treninoo/view/components/train_card.dart';
import 'package:treninoo/view/router/routes_names.dart';

class SavedTrainList extends StatelessWidget {
  const SavedTrainList({Key key, this.trains, this.savedTrainType})
      : super(key: key);

  final List<SavedTrain> trains;
  final SavedTrainType savedTrainType;

  get emptyText {
    switch (savedTrainType) {
      case SavedTrainType.recents:
        return "Nessun recente";
      case SavedTrainType.favourites:
        return "Nessun preferito";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (trains.length == 0)
      return Text(
        emptyText,
        textAlign: TextAlign.center,
      );

    return BlocListener<ExistBloc, ExistState>(
      listener: (context, state) {
        if (state is ExistSuccess) {
          LoadingDialog.hide(context);
          SavedTrain savedTrain = state.savedTrain;
          if (savedTrain != null) {
            Navigator.pushNamed(context, RoutesNames.status,
                    arguments: savedTrain)
                .then((value) {
              switch (savedTrainType) {
                case SavedTrainType.recents:
                  context.read<RecentsBloc>().add(RecentsRequest());
                  return;
                case SavedTrainType.favourites:
                  context.read<FavouritesBloc>().add(FavouritesRequest());
                  return;
              }
            });
          } else {
            RemoveTrainDialog.show(context,
                savedTrain: savedTrain,
                savedTrainType: savedTrainType, onConfirm: () {
              switch (savedTrainType) {
                case SavedTrainType.recents:
                  context.read<RecentsBloc>().add(RecentsRequest());
                  break;
                case SavedTrainType.favourites:
                  context.read<FavouritesBloc>().add(FavouritesRequest());
                  break;
              }
            });
          }
          return;
        }

        if (state is ExistFailed) LoadingDialog.hide(context);

        if (state is ExistLoading) LoadingDialog.show(context);
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trains.length,
        itemBuilder: (context, index) {
          return TrainCard(
            savedTrain: trains[index],
            type: savedTrainType,
          );
        },
      ),
    );
  }
}
