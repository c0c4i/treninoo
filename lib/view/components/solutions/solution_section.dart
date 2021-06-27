import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/solution_section_header.dart';
import 'package:treninoo/view/components/solutions/solution_section_stations.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSection extends StatelessWidget {
  final TrainSolution trainSolution;
  final int position;
  final int size;

  const SolutionSection({Key key, this.trainSolution, this.position, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      onPressed: () {
        SavedTrain train = new SavedTrain(
          trainCode: trainSolution.trainCode,
          departureStationName: trainSolution.departureStation,
        );
        Navigator.pushNamed(context, RoutesNames.status, arguments: train);
      },
      child: Column(
        children: [
          SolutionSectionHeader(
            trainType: trainSolution.trainType,
            trainCode: trainSolution.trainCode,
            departureTime: trainSolution.departureTime,
            arrivalTime: trainSolution.arrivalTime,
          ),
          SizedBox(height: 16),
          SolutionSectionStations(
            trainSolution: trainSolution,
          ),
        ],
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius(),
        ),
        padding: EdgeInsets.all(16),
      ),
    ));
  }

  BorderRadius getBorderRadius() {
    if (size == 1) return BorderRadius.circular(16);
    if (position == 0)
      return BorderRadius.vertical(
          top: Radius.circular(16), bottom: Radius.zero);
    if (position == size - 1)
      return BorderRadius.vertical(
          bottom: Radius.circular(16), top: Radius.zero);
    return BorderRadius.zero;
  }
}
