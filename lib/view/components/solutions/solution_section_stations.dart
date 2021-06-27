import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/view/components/solutions/solution_section_station_row.dart';

class SolutionSectionStations extends StatelessWidget {
  final TrainSolution trainSolution;

  const SolutionSectionStations({Key key, this.trainSolution})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SolutionSectionStationRow(
          stationName: trainSolution.departureStation,
          time: trainSolution.departureTime,
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
        SolutionSectionStationRow(
          stationName: trainSolution.arrivalStation,
          time: trainSolution.arrivalTime,
        ),
      ],
    );
  }
}
