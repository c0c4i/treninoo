import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainStatusStopStationCell extends StatelessWidget {
  const TrainStatusStopStationCell({
    Key key,
    this.enable,
    this.stationName,
    this.plannedArrival,
    this.plannedDeparture,
    this.actualArrival,
    this.actualDeparture,
  }) : super(key: key);

  final bool enable;
  final String stationName;
  final String plannedArrival;
  final String plannedDeparture;
  final String actualArrival;
  final String actualDeparture;

  String pickText() {
    if (actualArrival != null) return actualArrival;
    if (actualDeparture != null) return actualDeparture;
    if (plannedArrival != null) return plannedArrival;
    if (plannedDeparture != null) return plannedDeparture;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        stationName,
        style: TextStyle(
          fontSize: 16,
          color: enable ? AppColors.red : AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
