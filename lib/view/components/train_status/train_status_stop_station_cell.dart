import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusStopStationCell extends StatelessWidget {
  const TrainStatusStopStationCell({
    Key? key,
    required this.station,
    this.current = false,
    required this.suppressed,
  }) : super(key: key);

  final Station station;
  final bool current;
  final bool suppressed;

  get textColor {
    if (suppressed) return Grey.darker;
    if (current) return Primary.normal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(kRadius),
        highlightColor: Colors.transparent,
        onTap: !suppressed
            ? () {
                Navigator.pushNamed(context, RoutesNames.station,
                    arguments: station);
              }
            : null,
        child: Text(
          station.stationName,
          style: Typo.subheaderLight.copyWith(
            color: textColor,
            decoration: suppressed ? TextDecoration.lineThrough : null,
            decorationThickness: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
