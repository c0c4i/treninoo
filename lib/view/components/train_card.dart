import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

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
    return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: OutlinedButton(
          onPressed: () {
            context.read<ExistBloc>().add(ExistRequest(savedTrain: savedTrain));
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      savedTrain.trainType + " " + savedTrain.trainCode,
                      style: Typo.subheaderHeavy.copyWith(
                        color: Primary.normal,
                      ),
                      // style: TextStyle(
                      //     color: Primary.normal,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    savedTrain.departureTime,
                    style: Typo.subheaderHeavy.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(width: 16),
                  Text(
                    savedTrain.departureStationName,
                    style: Typo.subheaderHeavy.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 11),
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Primary.normal,
                  width: 1,
                  height: 8,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(width: 16),
                  Text(
                    savedTrain.arrivalStationName,
                    style: Typo.subheaderHeavy.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
            padding: EdgeInsets.all(kPadding),
          ),
        ));
  }
}
