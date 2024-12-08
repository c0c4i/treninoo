import 'package:flutter/material.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/view/components/solutions/solution_card.dart';

class SolutionsList extends StatelessWidget {
  const SolutionsList({
    Key? key,
    required this.solutions,
    required this.trainInfos,
  }) : super(key: key);

  final Solutions solutions;
  final Map<TrainSolution, TrainInfo> trainInfos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: solutions.solutions.length,
      itemBuilder: (context, index) {
        return SolutionCard(
          solution: solutions.solutions[index],
          trainInfos: trainInfos,
        );
      },
    );
  }
}
