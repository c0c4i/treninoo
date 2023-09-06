import 'package:flutter/material.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionSectionStationRow extends StatelessWidget {
  final String? stationName;
  final DateTime? time;

  const SolutionSectionStationRow({
    Key? key,
    this.stationName,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(
        //   Icons.location_on_outlined,
        //   color: Theme.of(context).iconTheme.color,
        // ),
        // SizedBox(width: kPadding),
        Container(
          width: 60,
          child: Text(
            formatTime(time!),
            style: Typo.subheaderHeavy.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        Expanded(
          child: Text(
            stationName!.toUpperCase(),
            style: Typo.subheaderHeavy.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
