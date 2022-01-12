import 'package:flutter/material.dart';
import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/view/components/solutions/solution_section.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionCard extends StatelessWidget {
  final Solution solution;

  const SolutionCard({Key key, this.solution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: OutlinedButton(
        onPressed: null,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: solution.trains.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index != 0 ? Divider(thickness: 1, height: 1) : Container(),
                SolutionSection(
                  trainSolution: solution.trains[index],
                  position: index,
                  size: solution.trains.length,
                ),
              ],
            );
          },
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
