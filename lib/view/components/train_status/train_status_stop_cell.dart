import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusStopCell extends StatelessWidget {
  const TrainStatusStopCell({
    Key? key,
    this.cellType,
    this.plannedArrival,
    this.plannedDeparture,
    this.actualArrival,
    this.actualDeparture,
  }) : super(key: key);

  final CellType? cellType;
  final String? plannedArrival;
  final String? plannedDeparture;
  final String? actualArrival;
  final String? actualDeparture;

  get text {
    if (actualArrival != null) return actualArrival;
    if (plannedArrival != null) return plannedArrival;

    if (actualDeparture != null) return actualDeparture;
    if (plannedDeparture != null) return plannedDeparture;

    switch (cellType) {
      case CellType.binary:
        return "-";
      case CellType.time:
        return "—:—";
      default:
        return null;
    }
  }

  get confirmed {
    if (actualArrival != null) return true;
    if (actualDeparture != null) return true;
    if (plannedArrival != null) return false;
    if (plannedDeparture != null) return false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Typo.subheaderLight.copyWith(
        color: !confirmed ? Grey.dark : null,
      ),
      textAlign: TextAlign.center,
    );
  }
}

enum CellType { time, binary }
