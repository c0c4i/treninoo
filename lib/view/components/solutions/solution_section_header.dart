import 'package:flutter/material.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/delay_chip.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionSectionHeader extends StatelessWidget {
  final String? trainType;
  final String? trainCode;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final int? delay;

  const SolutionSectionHeader({
    Key? key,
    this.trainType,
    this.trainCode,
    this.departureTime,
    this.arrivalTime,
    this.delay,
  }) : super(key: key);

  get title {
    if (trainType == "UB") return "Bus";
    return "$trainType" + (trainCode != null ? " $trainCode" : "");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                title,
                style: Typo.subheaderHeavy.copyWith(
                  color: Primary.normal,
                ),
              ),
              if (delay != null) DelayChip(delay: delay),
            ],
          ),
        ),
        Semantics(
          label:
              ", durata viaggio ${travelTimeSemantics(departureTime!, arrivalTime!)}.",
          excludeSemantics: true,
          child: Text(
            travelTime(departureTime!, arrivalTime!),
            style: Typo.subheaderHeavy.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
