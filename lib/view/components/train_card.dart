import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/dialog/remove_train_dialog.dart';
import 'package:treninoo/view/components/loading_dialog.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainCard extends StatelessWidget {
  final SavedTrain savedTrain;
  final SavedTrainType savedTrainType;

  const TrainCard({
    Key key,
    this.savedTrain,
    this.savedTrainType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExistBloc, ExistState>(
      listener: (context, state) {
        if (state is ExistSuccess) {
          LoadingDialog.hide(context);
          if (state.exist) {
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
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          // width: width,
          child: ElevatedButton(
            // onPressed: onPressed,
            onPressed: () {
              context
                  .read<ExistBloc>()
                  .add(ExistRequest(savedTrain: savedTrain));
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        savedTrain.trainType + " " + savedTrain.trainCode,
                        style: TextStyle(
                            color: AppColors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      savedTrain.departureTime,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 16),
                    Text(
                      savedTrain.departureStationName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(left: 11),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                    height: 16,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 16),
                    Text(
                      savedTrain.arrivalStationName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).scaffoldBackgroundColor),
              elevation: MaterialStateProperty.all<double>(4),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.all(16)),
            ),
          )),
    );
  }
}
