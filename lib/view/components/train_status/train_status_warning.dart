import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/warning.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusWarning extends StatelessWidget {
  const TrainStatusWarning({super.key, required this.warning});

  final String warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding / 2),
      decoration: BoxDecoration(
        color: Warning.lightest1,
        borderRadius: BorderRadius.circular(kRadius / 1.5),
        border: Border.all(color: Warning.light),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Warning.dark,
          ),
          SizedBox(width: kPadding / 2),
          Expanded(
            child: Text(
              warning,
              style: Typo.bodyLight.copyWith(
                color: Warning.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
