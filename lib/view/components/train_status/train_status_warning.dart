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
      margin: EdgeInsets.only(bottom: kPadding),
      decoration: BoxDecoration(
        color: Warning.lighter,
        borderRadius: BorderRadius.circular(kRadius / 1.5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Warning.darker,
          ),
          SizedBox(width: kPadding / 2),
          Expanded(
            child: Text(
              warning,
              style: Typo.bodyLight.copyWith(
                color: Warning.darker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
