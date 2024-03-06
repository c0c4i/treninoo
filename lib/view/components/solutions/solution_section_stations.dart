import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/solution_section_station_row.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSectionStations extends StatelessWidget {
  final TrainSolution? trainSolution;

  const SolutionSectionStations({Key? key, this.trainSolution})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          label:
              " In partenza alle ${formatTime(trainSolution!.departureTime!)} da ${trainSolution!.departureStation}.",
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.departureStation,
            time: trainSolution!.departureTime,
          ),
        ),
        // SizedBox(height: 8),
        // Container(
        //   padding: EdgeInsets.only(left: 11),
        //   alignment: Alignment.centerLeft,
        //   child: Container(
        //     color: Primary.normal,
        //     width: 1,
        //     height: 8,
        //   ),
        // ),
        SizedBox(height: kPadding),
        Semantics(
          label:
              " In arrivo alle ${formatTime(trainSolution!.arrivalTime!)} a ${trainSolution!.arrivalStation}.",
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.arrivalStation,
            time: trainSolution!.arrivalTime,
          ),
        ),
      ],
    );
  }
}
