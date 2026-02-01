import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/rail_chip.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionSectionStationRow extends StatelessWidget {
  final String? stationName;
  final DateTime? time;
  final String? rail;
  final bool? confirmedRail;

  const SolutionSectionStationRow({
    Key? key,
    this.stationName,
    this.time,
    this.rail,
    this.confirmedRail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          formatTime(time!),
          style: GoogleFonts.robotoMono().copyWith(
            fontSize: Typo.subheaderHeavy.fontSize,
            fontWeight: Typo.subheaderHeavy.fontWeight,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: kPadding),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              stationName!.toUpperCase(),
              style: Typo.subheaderHeavy.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (rail != null && confirmedRail != null)
          RailChip(
            rail: rail,
            confirmed: confirmedRail!,
          ),
      ],
    );
  }
}
