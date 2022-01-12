import 'package:flutter/material.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/view/components/solutions/solution_card.dart';

class SolutionsList extends StatelessWidget {
  const SolutionsList({Key key, this.solutions}) : super(key: key);

  final Solutions solutions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: solutions.solutions.length,
      itemBuilder: (context, index) {
        return SolutionCard(
          solution: solutions.solutions[index],
        );
      },
    );
  }
}
