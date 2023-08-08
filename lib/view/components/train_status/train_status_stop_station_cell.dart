import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusStopStationCell extends StatelessWidget {
  const TrainStatusStopStationCell({
    Key? key,
    this.stationName,
    this.current = false,
  }) : super(key: key);

  final String? stationName;
  final bool current;

  get textColor {
    if (current) return Primary.normal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        stationName!,
        style: Typo.subheaderLight.copyWith(color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
