import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainStatusStopCell extends StatelessWidget {
  const TrainStatusStopCell({
    Key key,
    this.cellType,
    this.plannedArrival,
    this.plannedDeparture,
    this.actualArrival,
    this.actualDeparture,
  }) : super(key: key);

  final CellType cellType;
  final String plannedArrival;
  final String plannedDeparture;
  final String actualArrival;
  final String actualDeparture;

  String pickText() {
    if (actualArrival != null) return actualArrival;
    if (plannedArrival != null) return plannedArrival;

    if (actualDeparture != null) return actualDeparture;
    if (plannedDeparture != null) return plannedDeparture;

    switch (cellType) {
      case CellType.binary:
        return "-";
      case CellType.time:
        return "—:—";
    }
    return null;
  }

  bool confirmed() {
    if (actualArrival != null) return true;
    if (actualDeparture != null) return true;
    if (plannedArrival != null) return false;
    if (plannedDeparture != null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      pickText(),
      style: TextStyle(
        fontSize: 16,
        color: confirmed() ? AppColors.black : AppColors.secondaryGrey,
      ),
      textAlign: TextAlign.center,
    );
  }
}

enum CellType { time, binary }
