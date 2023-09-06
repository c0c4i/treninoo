import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/view/components/solutions/solution_section_station_row.dart';
import 'package:treninoo/view/style/theme.dart';

import 'dot_line.dart';

class SolutionSectionStations extends StatelessWidget {
  final TrainSolution? trainSolution;

  const SolutionSectionStations({Key? key, this.trainSolution})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
          size: Size(24, 36), // Size of the canvas
          painter: VerticalDotLinePainter(),
        ),
        SizedBox(width: kPadding / 3),
        Expanded(
          child: Column(
            children: [
              SolutionSectionStationRow(
                stationName: trainSolution!.departureStation,
                time: trainSolution!.departureTime,
              ),
              SizedBox(height: kPadding),
              SolutionSectionStationRow(
                stationName: trainSolution!.arrivalStation,
                time: trainSolution!.arrivalTime,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
