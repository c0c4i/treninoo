import 'package:flutter/material.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionSectionStationRow extends StatelessWidget {
  final String stationName;
  final DateTime time;

  const SolutionSectionStationRow({
    Key key,
    this.stationName,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Colors.black,
        ),
        SizedBox(width: 16),
        Container(
          width: 70,
          child: Text(
            formatTime(time),
            style: Typo.subheaderHeavy.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        Text(
          stationName.toUpperCase(),
          style: Typo.subheaderHeavy.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        )
      ],
    );
  }
}
