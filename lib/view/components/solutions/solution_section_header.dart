import 'package:flutter/material.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionSectionHeader extends StatelessWidget {
  final String? trainType;
  final String? trainCode;
  final DateTime? departureTime;
  final DateTime? arrivalTime;

  const SolutionSectionHeader({
    Key? key,
    this.trainType,
    this.trainCode,
    this.departureTime,
    this.arrivalTime,
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
          child: Text(
            title,
            style: Typo.subheaderHeavy.copyWith(
              color: Primary.normal,
            ),
          ),
        ),
        Text(
          travelTime(departureTime!, arrivalTime!),
          style: Typo.subheaderHeavy.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
