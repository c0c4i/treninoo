import 'package:flutter/material.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusStopStationCell extends StatelessWidget {
  const TrainStatusStopStationCell({
    Key? key,
    this.stationName,
  }) : super(key: key);

  final String? stationName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        stationName!,
        style: Typo.subheaderLight,
        textAlign: TextAlign.center,
      ),
    );
  }
}
