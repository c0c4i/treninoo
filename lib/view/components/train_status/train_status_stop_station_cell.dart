import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusStopStationCell extends StatelessWidget {
  const TrainStatusStopStationCell({
    Key? key,
    required this.station,
    this.current = false,
  }) : super(key: key);

  final Station station;
  final bool current;

  get textColor {
    if (current) return Primary.normal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(kRadius),
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pushNamed(context, RoutesNames.station, arguments: station);
        },
        child: Text(
          station.stationName,
          style: Typo.subheaderLight.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
