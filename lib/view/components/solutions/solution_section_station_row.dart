import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSectionStationRow extends StatelessWidget {
  final String stationName;
  final DateTime time;

  const SolutionSectionStationRow({Key key, this.stationName, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Colors.black,
        ),
        SizedBox(width: 16),
        Container(
          width: 70,
          child: Text(
            formatTime(time),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
        Text(
          stationName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        )
      ],
    );
  }
}
