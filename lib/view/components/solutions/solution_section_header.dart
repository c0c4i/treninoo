import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSectionHeader extends StatelessWidget {
  final String trainType;
  final String trainCode;
  final DateTime departureTime;
  final DateTime arrivalTime;

  const SolutionSectionHeader(
      {Key key,
      this.trainType,
      this.trainCode,
      this.departureTime,
      this.arrivalTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$trainType $trainCode",
            style: TextStyle(
                color: AppColors.red,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          travelTime(departureTime, arrivalTime),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
