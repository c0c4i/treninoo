import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/accent.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainOrientationCard extends StatelessWidget {
  const TrainOrientationCard({super.key, required this.orientation});

  final String orientation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kPadding / 2,
        vertical: kPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Accent.lightest2,
        borderRadius: BorderRadius.circular(kRadius / 1.5),
        // border: Border.all(color: Accent.lighter),
      ),
      child: Row(
        children: [
          Icon(
            Icons.north_east_rounded,
            color: Accent.normal,
            size: 22,
          ),
          SizedBox(width: kPadding / 2),
          Expanded(
            child: Text(
              orientation,
              style: Typo.subheaderLight.copyWith(
                color: Accent.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
