import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/dialog/remove_train_dialog.dart';
import 'package:treninoo/view/components/loading_dialog.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class StationTrainCard extends StatelessWidget {
  final StationTrain stationTrain;

  const StationTrainCard({
    Key key,
    this.stationTrain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: () {
            // context.read<ExistBloc>().add(ExistRequest(savedTrain: savedTrain));
          },
          child: Row(
            children: [
              Text(
                stationTrain.category + " " + stationTrain.trainCode,
                style: TextStyle(
                    color: AppColors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              Column(
                children: [
                  Text(
                    stationTrain.time,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    stationTrain.time,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryGrey,
                    ),
                  ),
                ],
              ),
              Text(
                stationTrain.delay > 0 ? "+ ${stationTrain.delay} min" : "Nice",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                stationTrain.actualRail ?? stationTrain.plannedRail ?? "10",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                ),
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
        ));
  }
}
