import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusInfoAlert extends StatelessWidget {
  const TrainStatusInfoAlert({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding / 2),
      margin: EdgeInsets.only(bottom: kPadding),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(kRadius / 1.5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.blue,
            size: 22,
          ),
          SizedBox(width: kPadding / 2),
          Expanded(
            child: Text(
              text,
              style: Typo.bodyLight.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
