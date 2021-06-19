import 'package:flutter/material.dart';
import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/view/components/solutions/solution_section.dart';

class SolutionCard extends StatelessWidget {
  final Solution solution;

  const SolutionCard({Key key, this.solution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () {},
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
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).scaffoldBackgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
