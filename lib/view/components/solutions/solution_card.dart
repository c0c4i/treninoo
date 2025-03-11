import 'package:flutter/material.dart';
import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/solutions/solution_section.dart';
import 'package:treninoo/view/components/solutions/waiting_time_card.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionCard extends StatelessWidget {
  final Solution solution;
  final Map<TrainSolution, TrainInfo> trainInfos;

  const SolutionCard({
    Key? key,
    required this.solution,
    required this.trainInfos,
  }) : super(key: key);

  String get totalDuration => durationToString(totalDurationDuration);

  String get totalDurationSemantics =>
      durationToStringSemantics(totalDurationDuration);

  Duration get totalDurationDuration {
    Duration totalDuration = Duration();

    for (TrainSolution train in solution.trains) {
      totalDuration += train.arrivalTime!.difference(train.departureTime!);
    }

    // Add time between trains
    for (int i = 0; i < solution.trains.length - 1; i++) {
      totalDuration += solution.trains[i + 1].departureTime!.difference(
        solution.trains[i].arrivalTime!,
      );
    }

    return totalDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: kPadding / 2, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: OutlinedButton(
        onPressed: null,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: solution.trains.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index != 0)
                      WaitingTimeCard(
                        travelTime: travelTime(
                          solution.trains[index - 1].arrivalTime!,
                          solution.trains[index].departureTime!,
                        ),
                      ),
                    SolutionSection(
                      trainSolution: solution.trains[index],
                      position: index,
                      size: solution.trains.length,
                      trainInfo: trainInfos[solution.trains[index]],
                    ),
                  ],
                );
              },
            ),
            if (solution.trains.length > 1)
              Semantics(
                label: "Totale viaggio $totalDurationSemantics.",
                excludeSemantics: true,
                child: Column(
                  children: [
                    Divider(thickness: 1, height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kPadding,
                        horizontal: kPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Totale',
                            style: Typo.subheaderHeavy.copyWith(
                              color: Primary.normal,
                            ),
                          ),
                          Text(
                            totalDuration,
                            style: Typo.subheaderHeavy.copyWith(
                              color: Primary.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
