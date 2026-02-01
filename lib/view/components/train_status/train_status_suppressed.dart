import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/ErrorColor.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusSuppressed extends StatelessWidget {
  const TrainStatusSuppressed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding / 2),
      margin: EdgeInsets.only(bottom: kPadding),
      decoration: BoxDecoration(
        color: ErrorColor.lightest2,
        borderRadius: BorderRadius.circular(kRadius / 1.5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ErrorColor.dark,
          ),
          SizedBox(width: kPadding / 2),
          Expanded(
            child: Text(
              'Il treno è stato soppresso',
              style: Typo.bodyLight.copyWith(
                color: ErrorColor.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
