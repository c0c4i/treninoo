import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainInfoBinaries.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/solution_section_station_row.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSectionStations extends StatelessWidget {
  final TrainSolution? trainSolution;
  final TrainInfoRails? trainInfoRails;

  const SolutionSectionStations({
    Key? key,
    this.trainSolution,
    this.trainInfoRails,
  }) : super(key: key);

  String get departureSemanticsLabel {
    String time = formatTime(trainSolution!.departureTime!);
    String label = " In partenza alle $time da ${trainSolution!.origin}";
    if (trainInfoRails?.originRail == null) return label + ".";
    label += " dal binario ";
    if (!trainInfoRails!.originRailConfirmed) label += "provvisorio ";
    label += "${trainInfoRails!.originRail}";
    return label + ".";
  }

  String get arrivalSemanticsLabel {
    String time = formatTime(trainSolution!.arrivalTime!);
    String label = " In arrivo alle $time a ${trainSolution!.destination}";
    if (trainInfoRails?.destinationRail == null) return label + ".";
    label += " al binario ";
    if (!trainInfoRails!.destinationRailConfirmed) label += "provvisorio ";
    label += "${trainInfoRails!.destinationRail}";
    return label + ".";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          label: departureSemanticsLabel,
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.origin,
            time: trainSolution!.departureTime,
            rail: trainInfoRails?.originRail,
            confirmedRail: trainInfoRails?.originRailConfirmed,
          ),
        ),
        SizedBox(height: kPadding / 2),
        Semantics(
          label: arrivalSemanticsLabel,
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.destination,
            time: trainSolution!.arrivalTime,
            rail: trainInfoRails?.destinationRail,
            confirmedRail: trainInfoRails?.destinationRailConfirmed,
          ),
        ),
      ],
    );
  }
}
