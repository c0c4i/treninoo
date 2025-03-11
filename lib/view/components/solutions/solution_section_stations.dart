import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/solution_section_station_row.dart';
import 'package:treninoo/view/style/theme.dart';

enum RailType { departure, arrival }

class SolutionSectionStations extends StatelessWidget {
  final TrainSolution? trainSolution;
  final TrainInfo? trainInfo;

  const SolutionSectionStations({
    Key? key,
    this.trainSolution,
    this.trainInfo,
  }) : super(key: key);

  String? rail(RailType type) {
    if (trainInfo == null) return null;
    if (trainSolution!.originStation == null && type == RailType.departure)
      return null;
    if (trainSolution!.destinationStation == null && type == RailType.arrival)
      return null;

    String stationCode = type == RailType.departure
        ? trainSolution!.originStation!.stationCode
        : trainSolution!.destinationStation!.stationCode;
    Stop? stop = trainInfo!.findStopByStationCode(stationCode);

    return stop?.plannedArrivalRail ??
        stop?.plannedDepartureRail ??
        stop?.actualArrivalRail ??
        stop?.actualDepartureRail;
  }

  bool isRailConfirmed(RailType type) {
    if (trainInfo == null) return false;
    if (trainSolution!.originStation == null && type == RailType.departure)
      return false;
    if (trainSolution!.destinationStation == null && type == RailType.arrival)
      return false;

    Stop? stop = trainInfo!
        .findStopByStationCode(trainSolution!.originStation!.stationCode);

    return stop?.actualDepartureRail != null || stop?.actualArrivalRail != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          label:
              " In partenza alle ${formatTime(trainSolution!.departureTime!)} da ${trainSolution!.origin}.",
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.origin,
            time: trainSolution!.departureTime,
            rail: rail(RailType.departure),
            confirmedRail: isRailConfirmed(RailType.departure),
          ),
        ),
        SizedBox(height: kPadding),
        Semantics(
          label:
              " In arrivo alle ${formatTime(trainSolution!.arrivalTime!)} a ${trainSolution!.destination}.",
          excludeSemantics: true,
          child: SolutionSectionStationRow(
            stationName: trainSolution!.destination,
            time: trainSolution!.arrivalTime,
            rail: rail(RailType.arrival),
            confirmedRail: isRailConfirmed(RailType.arrival),
          ),
        ),
      ],
    );
  }
}
